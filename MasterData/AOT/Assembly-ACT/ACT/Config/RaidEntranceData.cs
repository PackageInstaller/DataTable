using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class RaidEntranceData
{
	public readonly int id;

	public readonly int[] raidId = new int[0];

	public readonly int raidType;

	public readonly int entranceName;

	public readonly int raidIconAddress;

	public readonly int bossEntityId;

	public readonly List<ItemKv> rewardItemShow;

	public readonly List<ItemKv> raidEntranUnlock;

	public readonly int unlockCondition;

	public readonly List<ItemKv> cost;

	public readonly int cycleOpenDesc;

	public readonly bool canUseTeam;

	public readonly bool reconnectReset;

	public readonly int[] defaultZoomType = new int[0];

	public readonly int[] cycleOpen = new int[0];

	public readonly bool isExperience;

	public readonly bool isFirstFree;

	public readonly bool skipJumpTraverse;

	public readonly int raidTipTitile;

	public readonly int raidTip;

	public RaidEntranceData(int id, int[] raidId, int raidType, int entranceName, int raidIconAddress, int bossEntityId, List<ItemKv> rewardItemShow, List<ItemKv> raidEntranUnlock, int unlockCondition, List<ItemKv> cost, int cycleOpenDesc, bool canUseTeam, bool reconnectReset, int[] defaultZoomType, int[] cycleOpen, bool isExperience, bool isFirstFree, bool skipJumpTraverse, int raidTipTitile, int raidTip)
	{
		this.id = id;
		this.raidId = raidId;
		this.raidType = raidType;
		this.entranceName = entranceName;
		this.raidIconAddress = raidIconAddress;
		this.bossEntityId = bossEntityId;
		this.rewardItemShow = rewardItemShow;
		this.raidEntranUnlock = raidEntranUnlock;
		this.unlockCondition = unlockCondition;
		this.cost = cost;
		this.cycleOpenDesc = cycleOpenDesc;
		this.canUseTeam = canUseTeam;
		this.reconnectReset = reconnectReset;
		this.defaultZoomType = defaultZoomType;
		this.cycleOpen = cycleOpen;
		this.isExperience = isExperience;
		this.isFirstFree = isFirstFree;
		this.skipJumpTraverse = skipJumpTraverse;
		this.raidTipTitile = raidTipTitile;
		this.raidTip = raidTip;
	}
}
