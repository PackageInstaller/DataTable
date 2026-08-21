using System.Collections.Generic;
using Ase;
using UnityEngine;

public class ClimbTowerWorldData : WorldData
{
	public int TowerNum;

	public List<int> TalentBuff;

	public List<int> SelectBuff;

	public int RefreshCount;

	public TowerConfig TowerConfig;

	public int CopyType;

	public int TowerIndex;

	public int EndlessLayer;

	public static WorldData CreateClimbTowerWorldData(uint serialId, string sceneName, int copyType, int towerNum, int towerIndex, int endlessLayer, TowerConfig towerConfig, int navMeshId, List<PeripheryHeroData> teamList, List<AchievementMedal> battleAchievementMedalList, List<TeamMember> teamMembers, List<int> talentBuff, List<int> rogueBuff, int refreshCount, int teachingId = 0)
	{
		return new ClimbTowerWorldData
		{
			WorldId = serialId,
			WorldName = sceneName,
			SceneLoadPath = "Activity/" + sceneName,
			TeamListConfig = teamList,
			NavMeshId = navMeshId,
			RandomSeed = Random.Range(0, 100),
			TowerNum = towerNum,
			TowerIndex = towerIndex,
			TowerConfig = towerConfig,
			TeachingId = teachingId,
			CopyType = copyType,
			BattleAchievementMedalList = battleAchievementMedalList,
			TeamMemberList = teamMembers,
			TalentBuff = talentBuff,
			SelectBuff = rogueBuff,
			RefreshCount = refreshCount,
			EndlessLayer = endlessLayer
		};
	}
}
