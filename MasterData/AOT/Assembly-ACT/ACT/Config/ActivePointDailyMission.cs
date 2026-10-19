using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ActivePointDailyMission
{
	public readonly int id;

	public readonly int name;

	public readonly int rewardPoint;

	public readonly List<ItemKv> activePointDailyReward;

	public readonly List<ItemKv> preconditionParam;

	public readonly int[] navigation = new int[0];

	public ActivePointDailyMission(int id, int name, int rewardPoint, List<ItemKv> activePointDailyReward, List<ItemKv> preconditionParam, int[] navigation)
	{
		this.id = id;
		this.name = name;
		this.rewardPoint = rewardPoint;
		this.activePointDailyReward = activePointDailyReward;
		this.preconditionParam = preconditionParam;
		this.navigation = navigation;
	}
}
