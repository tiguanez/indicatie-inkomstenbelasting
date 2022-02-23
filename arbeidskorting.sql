DELETE from inkomen;
WITH RECURSIVE cnt(bedrag) AS 
(
   SELECT
      1000 
   UNION ALL
   SELECT
      bedrag + 1000 
   FROM
      cnt LIMIT 200 
)
INSERT INTO
   inkomen(bedrag) 
   SELECT
      bedrag AS outased 
   FROM
      cnt;
SELECT bedrag, (
	SELECT CAST (hulpbedrag + hulppercentage * (bedrag - basisbedrag) as int)
--	SELECT hulpbedrag
	FROM korting
	WHERE type_id == 2 AND basisbedrag < bedrag
	ORDER BY basisbedrag DESC
--	LIMIT 1
) as arbeidskorting
FROM inkomen