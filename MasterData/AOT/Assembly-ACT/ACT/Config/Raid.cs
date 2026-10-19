using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class Raid
{
	public readonly int id;

	public readonly int raidName;

	public readonly int raidMark;

	public readonly int gameType;

	public readonly int bindMissionGroupId;

	public readonly int frontCondition;

	public readonly int countDown;

	public readonly List<ItemKv> raidPreUnlock;

	public readonly int unlockCondition;

	public readonly int listBanner;

	public readonly List<ItemKv> firstReward;

	public readonly int collectionReward;

	public readonly bool isDoubleRaid;

	public readonly int[] customEntry = new int[0];

	public readonly int sceneId;

	public readonly int ruleDescId;

	public readonly int commonDescId;

	public readonly int recommendTeamLevel;

	public readonly int[] mainTarget = new int[0];

	public readonly int numberOfRewardsReceived;

	public readonly List<ItemKv> cost;

	public readonly int[] tryRole = new int[0];

	public readonly int[] tryRoleinteam = new int[0];

	public readonly int belongEntranceData;

	public readonly bool cpUse;

	public readonly bool skipJumpTraverse;

	public readonly List<ItemKv> certain;

	public readonly List<Maybe> randomReward;

	public readonly int tryPotion;

	public Raid(int id, int raidName, int raidMark, int gameType, int bindMissionGroupId, int frontCondition, int countDown, List<ItemKv> raidPreUnlock, int unlockCondition, int listBanner, List<ItemKv> firstReward, int collectionReward, bool isDoubleRaid, int[] customEntry, int sceneId, int ruleDescId, int commonDescId, int recommendTeamLevel, int[] mainTarget, int numberOfRewardsReceived, List<ItemKv> cost, int[] tryRole, int[] tryRoleinteam, int belongEntranceData, bool cpUse, bool skipJumpTraverse, List<ItemKv> certain, List<Maybe> randomReward, int tryPotion)
	{
		this.id = id;
		this.raidName = raidName;
		this.raidMark = raidMark;
		this.gameType = gameType;
		this.bindMissionGroupId = bindMissionGroupId;
		this.frontCondition = frontCondition;
		this.countDown = countDown;
		this.raidPreUnlock = raidPreUnlock;
		this.unlockCondition = unlockCondition;
		this.listBanner = listBanner;
		this.firstReward = firstReward;
		this.collectionReward = collectionReward;
		this.isDoubleRaid = isDoubleRaid;
		this.customEntry = customEntry;
		this.sceneId = sceneId;
		this.ruleDescId = ruleDescId;
		this.commonDescId = commonDescId;
		this.recommendTeamLevel = recommendTeamLevel;
		this.mainTarget = mainTarget;
		this.numberOfRewardsReceived = numberOfRewardsReceived;
		this.cost = cost;
		this.tryRole = tryRole;
		this.tryRoleinteam = tryRoleinteam;
		this.belongEntranceData = belongEntranceData;
		this.cpUse = cpUse;
		this.skipJumpTraverse = skipJumpTraverse;
		this.certain = certain;
		this.randomReward = randomReward;
		this.tryPotion = tryPotion;
	}
}
