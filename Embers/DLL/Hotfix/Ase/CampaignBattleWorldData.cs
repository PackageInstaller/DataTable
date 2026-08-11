#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class CampaignBattleWorldData : LockstepBattleWorldData
{
	public CampaignMapData mapData;

	public List<int> Monsters;

	public Dictionary<int, int> MonsterCounts;

	public static CampaignBattleWorldData Create(int campaignID, uint serialId, List<PeripheryHeroData> teamList, List<TeamMember> teamMembers, int randomSeed, long roomId, long roomKey, long userId, int selfIndex, string ip, int port, uint localConnectId, List<AchievementMedal> battleAchievementMedalList, LockStepWorldType lockStepWorldType = LockStepWorldType.Normal)
	{
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(campaignID);
		if (dataRow == null)
		{
			Log.Error($"表数据不对 {campaignID}");
			return new CampaignBattleWorldData();
		}
		string campaignMapDataAsset = AssetUtility.GetCampaignMapDataAsset(dataRow.MapData);
		CampaignMapData campaignMapData = GameEntry.Resource.LoadAsset<CampaignMapData>(campaignMapDataAsset);
		if (campaignMapData == null)
		{
			return new CampaignBattleWorldData();
		}
		Dictionary<int, int> monsterCounts = GetMonsterCounts(campaignMapData);
		List<int> monsters = GetMonsters(monsterCounts);
		return new CampaignBattleWorldData
		{
			WorldId = serialId,
			WorldName = dataRow.SceneName,
			SceneLoadPath = "Campaign/" + dataRow.SceneName,
			NavMeshId = dataRow.NavMeshId,
			TeamListConfig = teamList,
			TeamMemberList = teamMembers,
			RandomSeed = randomSeed,
			CopyId = campaignID,
			SelfIndex = selfIndex,
			LockStepWorldType = lockStepWorldType,
			Ip = ip,
			Port = port,
			RoomId = roomId,
			UserId = userId,
			RoomKey = roomKey,
			LocalConnectId = localConnectId,
			BattleAchievementMedalList = battleAchievementMedalList,
			mapData = campaignMapData,
			Monsters = monsters,
			MonsterCounts = monsterCounts
		};
	}

	public static List<int> GetMonsters(Dictionary<int, int> monsterCounts)
	{
		if (monsterCounts == null || monsterCounts.Count == 0)
		{
			return new List<int>();
		}
		return new List<int>(monsterCounts.Keys);
	}

	public static Dictionary<int, int> GetMonsterCounts(CampaignMapData mapData)
	{
		Dictionary<int, int> preloadMonsterCounts = GetPreloadMonsterCounts(mapData);
		if (preloadMonsterCounts.Count == 0)
		{
			Log.Error("Campaign地图 " + (mapData?.name ?? "null") + " 缺少预加载怪物数量配置，请重新导出CampaignMapData。");
		}
		return preloadMonsterCounts;
	}

	private static Dictionary<int, int> GetPreloadMonsterCounts(CampaignMapData mapData)
	{
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		if (mapData?.preloadMonsterCounts == null)
		{
			return dictionary;
		}
		for (int i = 0; i < mapData.preloadMonsterCounts.Count; i++)
		{
			CampaignPreloadMonsterCountData campaignPreloadMonsterCountData = mapData.preloadMonsterCounts[i];
			if (campaignPreloadMonsterCountData != null && campaignPreloadMonsterCountData.monsterId > 0 && campaignPreloadMonsterCountData.count > 0)
			{
				if (dictionary.TryGetValue(campaignPreloadMonsterCountData.monsterId, out var value))
				{
					dictionary[campaignPreloadMonsterCountData.monsterId] = value + campaignPreloadMonsterCountData.count;
				}
				else
				{
					dictionary.Add(campaignPreloadMonsterCountData.monsterId, campaignPreloadMonsterCountData.count);
				}
			}
		}
		return dictionary;
	}
}
