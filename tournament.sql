-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


--create players table
create Table Players(
  id SERIAL PRIMARY KEY ,
  name TEXT
);

create Table Matches(
  id SERIAL PRIMARY KEY,
	player INTEGER REFERENCES Players(id),
	opponent INTEGER REFERENCES Players(id),
	result INTEGER
);

-- view for counting the number of wins
CREATE VIEW Wins AS
	SELECT Players.id, COUNT(Matches.opponent) AS w
	FROM Players
	LEFT JOIN (SELECT * FROM Matches WHERE result>0) as Matches
	ON Players.id = Matches.player
	GROUP BY Players.id;

--view for total number of matches
CREATE VIEW Count AS
	SELECT Players.id, Count(Matches.opponent) AS c
	FROM Players
	LEFT JOIN Matches
	ON Players.id = Matches.player
	GROUP BY Players.id;

--view for standing of players, showing number of wins and losses
CREATE VIEW Standings AS
	SELECT Players.id,Players.name,Wins.w as wins,Count.c as matches
	FROM Players,Count,Wins
	WHERE Players.id = Wins.id and Wins.id = Count.id;