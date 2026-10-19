using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class WorldBossMonster
{
	public readonly int id;

	public readonly int worldBossID;

	public readonly int bossType;

	public readonly int worldBossRaidId;

	public readonly int worldId;

	public readonly int worldBossTotalNumberOfRewardsCanClaimed;

	public readonly List<ItemKv> worldBossCost;

	public readonly List<ItemKv> worldBossRewardItemShow;

	public readonly int bossTeleportPoint;

	public readonly int[] monsterLevelShow = new int[0];

	public readonly int monsterPointUid;

	public readonly int rewardUid;

	public readonly int[] collectionId = new int[0];

	public readonly int worldBossInteractiveUid;

	public readonly int bossElementType;

	public readonly List<ItemKv> refreshPrecondition;

	public readonly int dwellArea;

	public readonly int subTitle;

	public readonly int listBanner;

	public WorldBossMonster(int id, int worldBossID, int bossType, int worldBossRaidId, int worldId, int worldBossTotalNumberOfRewardsCanClaimed, List<ItemKv> worldBossCost, List<ItemKv> worldBossRewardItemShow, int bossTeleportPoint, int[] monsterLevelShow, int monsterPointUid, int rewardUid, int[] collectionId, int worldBossInteractiveUid, int bossElementType, List<ItemKv> refreshPrecondition, int dwellArea, int subTitle, int listBanner)
	{
		this.id = id;
		this.worldBossID = worldBossID;
		this.bossType = bossType;
		this.worldBossRaidId = worldBossRaidId;
		this.worldId = worldId;
		this.worldBossTotalNumberOfRewardsCanClaimed = worldBossTotalNumberOfRewardsCanClaimed;
		this.worldBossCost = worldBossCost;
		this.worldBossRewardItemShow = worldBossRewardItemShow;
		this.bossTeleportPoint = bossTeleportPoint;
		this.monsterLevelShow = monsterLevelShow;
		this.monsterPointUid = monsterPointUid;
		this.rewardUid = rewardUid;
		this.collectionId = collectionId;
		this.worldBossInteractiveUid = worldBossInteractiveUid;
		this.bossElementType = bossElementType;
		this.refreshPrecondition = refreshPrecondition;
		this.dwellArea = dwellArea;
		this.subTitle = subTitle;
		this.listBanner = listBanner;
	}
}
