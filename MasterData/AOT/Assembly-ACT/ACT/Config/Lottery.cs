using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class Lottery
{
	public readonly int id;

	public readonly int desc;

	public readonly int lotteryid;

	public readonly List<ItemKv> certain;

	public readonly int weight;

	public readonly int guaranteedTimes;

	public readonly int max;

	public readonly int finalReward;

	public Lottery(int id, int desc, int lotteryid, List<ItemKv> certain, int weight, int guaranteedTimes, int max, int finalReward)
	{
		this.id = id;
		this.desc = desc;
		this.lotteryid = lotteryid;
		this.certain = certain;
		this.weight = weight;
		this.guaranteedTimes = guaranteedTimes;
		this.max = max;
		this.finalReward = finalReward;
	}
}
