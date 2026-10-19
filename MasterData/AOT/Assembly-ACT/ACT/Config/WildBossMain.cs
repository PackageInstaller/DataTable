using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class WildBossMain
{
	public readonly int id;

	public readonly int rewardsNums;

	public readonly int rewardsBuyingNums;

	public readonly List<ItemKv> price;

	public readonly int raidMessage;

	public readonly int raidMessageTitle;

	public WildBossMain(int id, int rewardsNums, int rewardsBuyingNums, List<ItemKv> price, int raidMessage, int raidMessageTitle)
	{
		this.id = id;
		this.rewardsNums = rewardsNums;
		this.rewardsBuyingNums = rewardsBuyingNums;
		this.price = price;
		this.raidMessage = raidMessage;
		this.raidMessageTitle = raidMessageTitle;
	}
}
