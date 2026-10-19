using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class BagChest
{
	public readonly int id;

	public readonly int type;

	public readonly bool isDirectOpen;

	public readonly int missionGroupId;

	public readonly List<Maybe> randomRewardPool;

	public readonly List<ItemKv> selectableRewardPool;

	public readonly List<ItemKv> reward;

	public readonly List<ItemKv> rewardLimit;

	public readonly int descLocal;

	public readonly int poolRewardId;

	public readonly bool skipJumpTraverse;

	public BagChest(int id, int type, bool isDirectOpen, int missionGroupId, List<Maybe> randomRewardPool, List<ItemKv> selectableRewardPool, List<ItemKv> reward, List<ItemKv> rewardLimit, int descLocal, int poolRewardId, bool skipJumpTraverse)
	{
		this.id = id;
		this.type = type;
		this.isDirectOpen = isDirectOpen;
		this.missionGroupId = missionGroupId;
		this.randomRewardPool = randomRewardPool;
		this.selectableRewardPool = selectableRewardPool;
		this.reward = reward;
		this.rewardLimit = rewardLimit;
		this.descLocal = descLocal;
		this.poolRewardId = poolRewardId;
		this.skipJumpTraverse = skipJumpTraverse;
	}
}
