using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemObtainJump
{
	public readonly int id;

	public readonly int[] monsterPoints = new int[0];

	public readonly int[] wildBossMonsterPoints = new int[0];

	public readonly int[] collectionPoints = new int[0];

	public readonly int[] abyssLayers = new int[0];

	public readonly int[] raids = new int[0];

	public readonly int[] temples = new int[0];

	public readonly int[] shops = new int[0];

	public readonly List<ItemKv> shopSaleLists;

	public readonly int[] missions = new int[0];

	public readonly bool compose;

	public readonly int[] gacha = new int[0];

	public readonly int[] abyssConstantStar = new int[0];

	public readonly int[] abyssCycleStar = new int[0];

	public readonly int[] templeStar = new int[0];

	public readonly int[] activities = new int[0];

	public readonly int[] bagChest = new int[0];

	public readonly int[] battlePass = new int[0];

	public readonly List<ItemKv> worldLevelMonsterPoints;

	public readonly int[] handbookDailyMissionPointRewardID = new int[0];

	public ItemObtainJump(int id, int[] monsterPoints, int[] wildBossMonsterPoints, int[] collectionPoints, int[] abyssLayers, int[] raids, int[] temples, int[] shops, List<ItemKv> shopSaleLists, int[] missions, bool compose, int[] gacha, int[] abyssConstantStar, int[] abyssCycleStar, int[] templeStar, int[] activities, int[] bagChest, int[] battlePass, List<ItemKv> worldLevelMonsterPoints, int[] handbookDailyMissionPointRewardID)
	{
		this.id = id;
		this.monsterPoints = monsterPoints;
		this.wildBossMonsterPoints = wildBossMonsterPoints;
		this.collectionPoints = collectionPoints;
		this.abyssLayers = abyssLayers;
		this.raids = raids;
		this.temples = temples;
		this.shops = shops;
		this.shopSaleLists = shopSaleLists;
		this.missions = missions;
		this.compose = compose;
		this.gacha = gacha;
		this.abyssConstantStar = abyssConstantStar;
		this.abyssCycleStar = abyssCycleStar;
		this.templeStar = templeStar;
		this.activities = activities;
		this.bagChest = bagChest;
		this.battlePass = battlePass;
		this.worldLevelMonsterPoints = worldLevelMonsterPoints;
		this.handbookDailyMissionPointRewardID = handbookDailyMissionPointRewardID;
	}
}
