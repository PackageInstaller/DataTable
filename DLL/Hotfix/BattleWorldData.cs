using System.Collections.Generic;
using Ase;
using UnityEngine;

public class BattleWorldData : WorldData
{
	public int BossId;

	public int CopyId;

	public int SelfIndex;

	public static WorldData CreateBattleWorldData(uint serialId, string sceneName, int copyId, int bossId, string mapDataName, int navMeshId, List<PeripheryHeroData> teamList, List<TeamMember> teamMembers, PreloadBattleData preloadBattleData, List<AchievementMedal> battleAchievementMedalList, bool isOpenGm = false, int teachingId = 0)
	{
		return new BattleWorldData
		{
			WorldId = serialId,
			WorldName = sceneName,
			SceneLoadPath = "Copy/" + sceneName,
			MapDataName = mapDataName,
			TeamListConfig = teamList,
			TeamMemberList = teamMembers,
			NavMeshId = navMeshId,
			RandomSeed = Random.Range(0, 100),
			BossId = bossId,
			CopyId = copyId,
			PreloadBattleData = preloadBattleData,
			BattleAchievementMedalList = battleAchievementMedalList,
			IsOpenGM = isOpenGm,
			TeachingId = teachingId
		};
	}

	public static WorldData CreateMutilBattleWorldData(uint serialId, string sceneName, int copyId, int bossId, string mapDataName, int navMeshId, List<PeripheryHeroData> teamList, List<TeamMember> teamMembers, PreloadBattleData preloadBattleData, List<AchievementMedal> battleAchievementMedalList, int randomSeed, bool isOpenGm = false, int teachingId = 0)
	{
		return new BattleWorldData
		{
			WorldId = serialId,
			WorldName = sceneName,
			SceneLoadPath = "Copy/" + sceneName,
			MapDataName = mapDataName,
			TeamListConfig = teamList,
			TeamMemberList = teamMembers,
			NavMeshId = navMeshId,
			RandomSeed = randomSeed,
			BossId = bossId,
			CopyId = copyId,
			PreloadBattleData = preloadBattleData,
			BattleAchievementMedalList = battleAchievementMedalList,
			IsOpenGM = isOpenGm,
			TeachingId = teachingId,
			isMutil = true
		};
	}
}
