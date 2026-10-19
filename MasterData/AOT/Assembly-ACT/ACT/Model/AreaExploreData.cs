using System.Collections.Generic;
using ACT.Config;
using ACT.Game.Data;
using ACT.World;

namespace ACT.Model;

public class AreaExploreData
{
	public ACT.World.MapArea mapArea;

	private Dictionary<int, SubAreaExploreData> subAreaGroupDic;

	private Dictionary<int, bool> claimedRewardDic;

	private float areaExploreRatio;

	public AreaExploreData(MapAreaExplore areaExplore)
	{
		mapArea = (ACT.World.MapArea)areaExplore.Id;
		areaExploreRatio = areaExplore.TotalExplore;
		subAreaGroupDic = new Dictionary<int, SubAreaExploreData>();
		claimedRewardDic = new Dictionary<int, bool>();
		foreach (KeyValuePair<int, MapSubAreaExplore> item in areaExplore.SubAreaExplore)
		{
			if (!subAreaGroupDic.ContainsKey(item.Key))
			{
				subAreaGroupDic.Add(item.Key, new SubAreaExploreData(item.Value));
			}
		}
		foreach (KeyValuePair<int, bool> item2 in areaExplore.ClaimedReward)
		{
			if (!claimedRewardDic.ContainsKey(item2.Key))
			{
				claimedRewardDic.Add(item2.Key, item2.Value);
			}
		}
	}

	public void UpdateAreaExploreData(MapAreaExplore areaExplore)
	{
		mapArea = (ACT.World.MapArea)areaExplore.Id;
		areaExploreRatio = areaExplore.TotalExplore;
		foreach (MapSubAreaExplore value in areaExplore.SubAreaExplore.Values)
		{
			if (!subAreaGroupDic.ContainsKey(value.Id))
			{
				subAreaGroupDic.Add(value.Id, new SubAreaExploreData(value));
			}
			else
			{
				subAreaGroupDic[value.Id].UpdateSubAreaExploreData(value);
			}
		}
		foreach (KeyValuePair<int, bool> item in areaExplore.ClaimedReward)
		{
			claimedRewardDic[item.Key] = item.Value;
		}
	}

	public Dictionary<int, SubAreaExploreData> GetSubAreaData()
	{
		return subAreaGroupDic;
	}

	public Dictionary<int, bool> GetClaimedRewardDic()
	{
		return claimedRewardDic;
	}

	public bool CheckHaveReward()
	{
		List<ExplorationReward> explorationRewards = GetExplorationRewards();
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
		return Model<MapModel>.Interface.GetMapExploreRewardData((int)mapArea);
	}

	public float GetAreaExploreRatio()
	{
		return areaExploreRatio;
	}
}
