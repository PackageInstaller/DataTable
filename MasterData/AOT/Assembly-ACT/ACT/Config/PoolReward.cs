using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class PoolReward
{
	public readonly int id;

	public readonly int type;

	public readonly bool isDirectOpen;

	public readonly int missionGroupId;

	public readonly List<Maybe> randomRewardPool;

	public readonly List<ItemKv> selectableRewardPool;

	public readonly List<ItemKv> reward;

	public readonly int descLocal;

	public PoolReward(int id, int type, bool isDirectOpen, int missionGroupId, List<Maybe> randomRewardPool, List<ItemKv> selectableRewardPool, List<ItemKv> reward, int descLocal)
	{
		this.id = id;
		this.type = type;
		this.isDirectOpen = isDirectOpen;
		this.missionGroupId = missionGroupId;
		this.randomRewardPool = randomRewardPool;
		this.selectableRewardPool = selectableRewardPool;
		this.reward = reward;
		this.descLocal = descLocal;
	}
}
