#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase;
using GameFramework;

public class GameBackWorldData : BattleWorldData
{
	public List<GlobalBattleFrame> GlobalBattleFrameList;

	public List<SingleBattleFrameMessage> OneBattleFrameMessage;

	public ActivityMapData mapData;

	public List<int> Monsters;

	public int CurStage;

	public bool IsActivityBattle => mapData != null;

	public static WorldData CreateGameBackWorldData(uint serialId, string sceneName, int copyId, int bossId, string mapDataName, int navMeshId, List<PeripheryHeroData> teamList, PreloadBattleData preloadBattleData, int randomSeed, int selfIndex, List<GlobalBattleFrame> globalBattleFrameList)
	{
		return new GameBackWorldData
		{
			WorldId = serialId,
			WorldName = sceneName,
			SceneLoadPath = "Copy/" + sceneName,
			MapDataName = mapDataName,
			TeamListConfig = teamList,
			NavMeshId = navMeshId,
			RandomSeed = randomSeed,
			CopyId = copyId,
			BossId = bossId,
			PreloadBattleData = preloadBattleData,
			SelfIndex = selfIndex,
			GlobalBattleFrameList = globalBattleFrameList
		};
	}

	public static WorldData CreateGameBackWorldData(uint serialId, string sceneName, int copyId, int bossId, string mapDataName, int navMeshId, List<PeripheryHeroData> teamList, PreloadBattleData preloadBattleData, int randomSeed, int selfIndex, List<SingleBattleFrameMessage> oneBattleFrameMessage)
	{
		return new GameBackWorldData
		{
			WorldId = serialId,
			WorldName = sceneName,
			SceneLoadPath = "Copy/" + sceneName,
			MapDataName = mapDataName,
			TeamListConfig = teamList,
			NavMeshId = navMeshId,
			RandomSeed = randomSeed,
			CopyId = copyId,
			BossId = bossId,
			PreloadBattleData = preloadBattleData,
			SelfIndex = selfIndex,
			OneBattleFrameMessage = oneBattleFrameMessage
		};
	}

	public static WorldData CreateActivityGameBackWorldData(uint serialId, int copyId, List<PeripheryHeroData> teamList, PreloadBattleData preloadBattleData, int randomSeed, int selfIndex, int curStage, List<GlobalBattleFrame> globalBattleFrameList)
	{
		GameBackWorldData gameBackWorldData = CreateActivityBaseWorldData(serialId, copyId, teamList, preloadBattleData, randomSeed, selfIndex, curStage);
		if (gameBackWorldData != null)
		{
			gameBackWorldData.GlobalBattleFrameList = globalBattleFrameList;
		}
		return gameBackWorldData;
	}

	public static WorldData CreateActivityGameBackWorldData(uint serialId, int copyId, List<PeripheryHeroData> teamList, PreloadBattleData preloadBattleData, int randomSeed, int selfIndex, int curStage, List<SingleBattleFrameMessage> oneBattleFrameMessage)
	{
		GameBackWorldData gameBackWorldData = CreateActivityBaseWorldData(serialId, copyId, teamList, preloadBattleData, randomSeed, selfIndex, curStage);
		if (gameBackWorldData != null)
		{
			gameBackWorldData.OneBattleFrameMessage = oneBattleFrameMessage;
		}
		return gameBackWorldData;
	}

	private static GameBackWorldData CreateActivityBaseWorldData(uint serialId, int copyId, List<PeripheryHeroData> teamList, PreloadBattleData preloadBattleData, int randomSeed, int selfIndex, int curStage)
	{
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(copyId);
		if (dataRow == null)
		{
			Log.Error($"表数据不对 {copyId}");
			return null;
		}
		string activityMapDataAsset = Ase.AssetUtility.GetActivityMapDataAsset(dataRow.ActivityMapData);
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
			Log.Error($"表数据不对 {copyId}");
			return null;
		}
		return new GameBackWorldData
		{
			WorldId = serialId,
			WorldName = dRActivityScene.SceneName,
			SceneLoadPath = "Activity/" + dRActivityScene.SceneName,
			TeamListConfig = teamList,
			NavMeshId = dRActivityScene.NavMeshId,
			RandomSeed = randomSeed,
			CopyId = copyId,
			BossId = bossID,
			PreloadBattleData = preloadBattleData,
			SelfIndex = selfIndex,
			CurStage = curStage,
			Monsters = monsters,
			mapData = activityMapData
		};
	}

	private static List<int> GetMonsters(ActivityMapData activityMapData, int curStage, ref int bossID)
	{
		List<int> list = new List<int>();
		List<ActivityMapDataGroup> allGroupData = activityMapData.stages[curStage].allGroupData;
		if (allGroupData != null)
		{
			for (int i = 0; i < allGroupData.Count; i++)
			{
				for (int j = 0; j < allGroupData[i].rounds.Count; j++)
				{
					for (int k = 0; k < allGroupData[i].rounds[j].roundObjs.Count; k++)
					{
						ActivityMapDataObjData activityMapDataObjData = allGroupData[i].rounds[j].roundObjs[k];
						if (activityMapDataObjData.objType == ActivityMapDataObjType.Monster)
						{
							list.Add(activityMapDataObjData.id);
						}
						if (bossID == 0 && j == 0)
						{
							bossID = GetBossID(activityMapDataObjData.id);
						}
					}
				}
			}
		}
		return list;
	}

	private static int GetBossID(int id)
	{
		DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(id);
		if (dataRow == null)
		{
			return 0;
		}
		DRMonster dataRow2 = GameEntry.DataTable.GetDataRow<DRMonster>(dataRow.MonsterType);
		if (dataRow2 != null && dataRow2.IsBoss)
		{
			return id;
		}
		return 0;
	}
}
