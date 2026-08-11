using System.Collections.Generic;
using Ase;
using UnityEngine;

public class LevelWorldData : WorldData
{
	public int LevelId;

	public static WorldData CreateLevelWorldData(uint serialId, string sceneName, int levelId, string mapDataName, string bonfireKey, int navMeshId, List<PeripheryHeroData> teamList, int teachingId = 0)
	{
		return new LevelWorldData
		{
			WorldId = serialId,
			WorldName = sceneName,
			SceneLoadPath = "Level/" + sceneName,
			MapDataName = mapDataName,
			TeamListConfig = teamList,
			BonfireKey = bonfireKey,
			NavMeshId = navMeshId,
			RandomSeed = Random.Range(0, 100),
			LevelId = levelId,
			TeachingId = teachingId
		};
	}
}
