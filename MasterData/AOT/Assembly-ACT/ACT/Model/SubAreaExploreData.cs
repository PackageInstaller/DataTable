using System.Collections.Generic;
using ACT.Config;
using ACT.Game.Data;

namespace ACT.Model;

public class SubAreaExploreData
{
	public int subAreaId;

	private Dictionary<int, MapExploreGroupProgress> groupDic;

	private Dictionary<int, MapChunkExplore> chunkExplores;

	private Dictionary<int, bool> claimedRewardDic;

	private float areaExploreRatio;

	public SubAreaExploreData(MapSubAreaExplore areaExplore)
	{
		subAreaId = areaExplore.Id;
		areaExploreRatio = areaExplore.TotalExplore;
		groupDic = new Dictionary<int, MapExploreGroupProgress>();
		claimedRewardDic = new Dictionary<int, bool>();
		chunkExplores = new Dictionary<int, MapChunkExplore>();
		foreach (KeyValuePair<int, MapExploreGroupProgress> item in areaExplore.GroupExplore)
		{
			if (!groupDic.ContainsKey(item.Key))
			{
				groupDic.Add(item.Key, item.Value);
			}
		}
		foreach (KeyValuePair<int, bool> item2 in areaExplore.ClaimedReward)
		{
			if (!claimedRewardDic.ContainsKey(item2.Key))
			{
				claimedRewardDic.Add(item2.Key, item2.Value);
			}
		}
		foreach (KeyValuePair<int, MapChunkExplore> item3 in areaExplore.ChunkExplore)
		{
			if (!chunkExplores.ContainsKey(item3.Key))
			{
				chunkExplores.Add(item3.Key, item3.Value);
			}
		}
	}

	public void UpdateSubAreaExploreData(MapSubAreaExplore areaExplore)
	{
		subAreaId = areaExplore.Id;
		areaExploreRatio = areaExplore.TotalExplore;
		foreach (KeyValuePair<int, MapExploreGroupProgress> item in areaExplore.GroupExplore)
		{
			groupDic[item.Key] = item.Value;
		}
		foreach (KeyValuePair<int, bool> item2 in areaExplore.ClaimedReward)
		{
			claimedRewardDic[item2.Key] = item2.Value;
		}
		foreach (KeyValuePair<int, MapChunkExplore> item3 in areaExplore.ChunkExplore)
		{
			chunkExplores[item3.Key] = item3.Value;
		}
	}

	public Dictionary<int, bool> GetClaimedRewardDic()
	{
		return claimedRewardDic;
	}

	public MapExploreGroupProgress GetGroupExploreRatioById(int groupId)
	{
		if (groupDic.TryGetValue(groupId, out var value))
		{
			return value;
		}
		return null;
	}

	public MapChunkExplore GetChunkExploreByChunkId(int chunkId)
	{
		if (chunkExplores.TryGetValue(chunkId, out var value))
		{
			return value;
		}
		return null;
	}

	public Dictionary<int, MapExploreGroupProgress> GetGroupExploreRatio()
	{
		return groupDic;
	}

	public bool CheckHaveReward()
	{
		List<ExplorationReward> explorationRewards = GetExplorationRewards();
		if (explorationRewards == null)
		{
			return false;
		}
		explorationRewards.Sort((ExplorationReward a, ExplorationReward b) =>
		{
			int id = a.id;
			return id.CompareTo(b.id);
		});
		int count = explorationRewards.Count;
		bool result = false;
		for (int num = 0; num < count; num++)
		{
			if (!claimedRewardDic.ContainsKey(explorationRewards[num].id) && GetAreaExploreRatio() >= (float)explorationRewards[num].rewardProgress)
			{
				return true;
			}
		}
		return result;
	}

	public List<ExplorationReward> GetExplorationRewards()
	{
		return Model<MapModel>.Interface.GetMapExploreRewardData(subAreaId);
	}

	public float GetAreaExploreRatio()
	{
		return areaExploreRatio;
	}

	public int GetSubAreaId()
	{
		return subAreaId;
	}
}
