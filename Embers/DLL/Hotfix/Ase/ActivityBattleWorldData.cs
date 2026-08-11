#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase;

public class ActivityBattleWorldData : LockstepBattleWorldData
{
	public ActivityMapData mapData;

	public BattleWorldMode worldMode;

	public List<int> Monsters;

	public int CurStage;

	public static ActivityBattleWorldData Create(int activityID, uint serialId, List<PeripheryHeroData> teamList, PreloadBattleData preloadBattleData, int randomSeed, long roomId, long roomKey, int curStage, long userId, int selfIndex, string ip, int port, uint localConnectId, List<AchievementMedal> battleAchievementMedalList, int teachId, BattleWorldMode battleWorld = BattleWorldMode.SingleBattle, LockStepWorldType lockStepWorldType = LockStepWorldType.Normal)
	{
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(activityID);
		if (dataRow == null)
		{
			Log.Error($"表数据不对 {activityID}");
			return new ActivityBattleWorldData();
		}
		string activityMapDataAsset = AssetUtility.GetActivityMapDataAsset(dataRow.ActivityMapData);
		ActivityMapData activityMapData = GameEntry.Resource.LoadAsset<ActivityMapData>(activityMapDataAsset);
		DRActivityScene dRActivityScene = null;
		List<int> monsters = new List<int>();
		int bossID = 0;
		if (activityMapData != null)
		{
			dRActivityScene = GameEntry.DataTable.GetDataRow<DRActivityScene>(activityMapData.StartSceneId);
			monsters = GetMonsters(activityMapData, curStage, ref bossID);
		}
		if (dRActivityScene == null)
		{
			Log.Error($"表数据不对 {activityID}");
			return new ActivityBattleWorldData();
		}
		return new ActivityBattleWorldData
		{
			WorldId = serialId,
			WorldName = dRActivityScene.SceneName,
			SceneLoadPath = "Activity/" + dRActivityScene.SceneName,
			CurStage = curStage,
			TeamListConfig = teamList,
			NavMeshId = dRActivityScene.NavMeshId,
			RandomSeed = randomSeed,
			PreloadBattleData = preloadBattleData,
			SelfIndex = selfIndex,
			CopyId = activityID,
			Ip = ip,
			Port = port,
			RoomId = roomId,
			UserId = userId,
			RoomKey = roomKey,
			BattleAchievementMedalList = battleAchievementMedalList,
			LocalConnectId = localConnectId,
			Monsters = monsters,
			BossId = bossID,
			mapData = activityMapData,
			TeachingId = teachId,
			worldMode = battleWorld,
			LockStepWorldType = lockStepWorldType
		};
	}

	private static List<int> GetMonsters(ActivityMapData mapData, int curStage, ref int bossID)
	{
		List<int> list = new List<int>();
		List<ActivityMapDataGroup> allGroupData = mapData.stages[curStage].allGroupData;
		if (allGroupData != null)
		{
			for (int i = 0; i < allGroupData.Count; i++)
			{
				for (int j = 0; j < allGroupData[i].rounds.Count; j++)
				{
					for (int k = 0; k < allGroupData[i].rounds[j].roundObjs.Count; k++)
					{
						if (allGroupData[i].rounds[j].roundObjs[k].objType == ActivityMapDataObjType.Monster)
						{
							list.Add(allGroupData[i].rounds[j].roundObjs[k].id);
						}
						if (bossID == 0 && j == 0)
						{
							bossID = GetBossID(allGroupData[i].rounds[j].roundObjs[k].id);
						}
					}
				}
			}
		}
		return list;
	}

	private static int GetBossID(int id)
	{
		int result = 0;
		DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(id);
		if (dataRow != null)
		{
			DRMonster dataRow2 = GameEntry.DataTable.GetDataRow<DRMonster>(dataRow.MonsterType);
			if (dataRow2 != null && dataRow2.IsBoss)
			{
				result = id;
			}
		}
		return result;
	}

	public static ActivityBattleWorldData Create(int activityID, uint serialId, int curStage, List<PeripheryHeroData> teamList, PreloadBattleData preloadBattleData, List<AchievementMedal> battleAchievementMedalList, bool isOpenGm = false)
	{
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(activityID);
		if (dataRow == null)
		{
			Log.Error($"表数据不对 {activityID}");
			return new ActivityBattleWorldData();
		}
		string activityMapDataAsset = AssetUtility.GetActivityMapDataAsset(dataRow.ActivityMapData);
		ActivityMapData activityMapData = GameEntry.Resource.LoadAsset<ActivityMapData>(activityMapDataAsset);
		DRActivityScene dRActivityScene = null;
		List<int> list = new List<int>();
		if (activityMapData != null)
		{
			dRActivityScene = GameEntry.DataTable.GetDataRow<DRActivityScene>(activityMapData.StartSceneId);
			List<ActivityMapDataGroup> allGroupData = activityMapData.stages[curStage].allGroupData;
			if (allGroupData != null)
			{
				for (int i = 0; i < allGroupData.Count; i++)
				{
					for (int j = 0; j < allGroupData[i].rounds.Count; j++)
					{
						for (int k = 0; k < allGroupData[i].rounds[j].roundObjs.Count; k++)
						{
							if (allGroupData[i].rounds[j].roundObjs[k].objType == ActivityMapDataObjType.Monster)
							{
								list.Add(allGroupData[i].rounds[j].roundObjs[k].id);
							}
						}
					}
				}
			}
		}
		return new ActivityBattleWorldData
		{
			WorldId = serialId,
			WorldName = dRActivityScene.SceneName,
			SceneLoadPath = "Activity/" + dRActivityScene.SceneName,
			TeamListConfig = teamList,
			NavMeshId = (dRActivityScene?.NavMeshId ?? 1),
			RandomSeed = Random.Range(0, 100),
			PreloadBattleData = preloadBattleData,
			BattleAchievementMedalList = battleAchievementMedalList,
			IsOpenGM = isOpenGm,
			mapData = activityMapData,
			Monsters = list,
			SelfIndex = 0,
			CopyId = dRActivityScene.Id
		};
	}
}
