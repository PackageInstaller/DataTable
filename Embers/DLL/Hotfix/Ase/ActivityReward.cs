using System.Collections.Generic;

namespace Ase;

public struct ActivityReward
{
	public RewardThings Rewards;

	public List<ActivityTaskData> Datas;

	public bool Result;

	public int ErrorCode;

	public bool RewardEmpty()
	{
		if (Rewards != null)
		{
			if (Rewards.propItems == null)
			{
				return Rewards.heroRewardInfos == null;
			}
			return false;
		}
		return true;
	}

	public bool DataEmpty()
	{
		if (Datas != null)
		{
			return Datas.Count <= 0;
		}
		return true;
	}
}
