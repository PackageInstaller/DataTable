using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class Gacha
{
	public readonly int id;

	public readonly int gachaName;

	public readonly int gachaType;

	public readonly int displayPriority;

	public readonly string typeProperty = "";

	public readonly long startTime;

	public readonly long endTime;

	public readonly int[] poolList = new int[0];

	public readonly List<ItemKv> token;

	public readonly int multiNum;

	public readonly int countForMustHighQualityUp;

	public readonly int[] multiGuarantPool = new int[0];

	public readonly int prdNum;

	public readonly int bigGuarantNum;

	public readonly int[] bigGuarantPool = new int[0];

	public readonly int milestonePull;

	public readonly List<ItemKv> milestoneReward;

	public readonly int finalGuarantNum;

	public readonly int[] finalGuarantPool = new int[0];

	public readonly bool isFinalGuarantRepeatable;

	public readonly bool isFinalGuarantSelectable;

	public readonly bool skipJumpTraverse;

	public readonly int[] gachaPoolProbability = new int[0];

	public readonly int discountPercent;

	public readonly int discountEligiblePulls;

	public readonly int maxPulls;

	public readonly bool isTenPullOnly;

	public readonly int bgPerfeb;

	public readonly int uptestJump;

	public readonly int maxTargetPoint;

	public readonly int targetCharacterPool;

	public readonly int[] targetCharacterShows = new int[0];

	public Gacha(int id, int gachaName, int gachaType, int displayPriority, string typeProperty, long startTime, long endTime, int[] poolList, List<ItemKv> token, int multiNum, int countForMustHighQualityUp, int[] multiGuarantPool, int prdNum, int bigGuarantNum, int[] bigGuarantPool, int milestonePull, List<ItemKv> milestoneReward, int finalGuarantNum, int[] finalGuarantPool, bool isFinalGuarantRepeatable, bool isFinalGuarantSelectable, bool skipJumpTraverse, int[] gachaPoolProbability, int discountPercent, int discountEligiblePulls, int maxPulls, bool isTenPullOnly, int bgPerfeb, int uptestJump, int maxTargetPoint, int targetCharacterPool, int[] targetCharacterShows)
	{
		this.id = id;
		this.gachaName = gachaName;
		this.gachaType = gachaType;
		this.displayPriority = displayPriority;
		this.typeProperty = typeProperty;
		this.startTime = startTime;
		this.endTime = endTime;
		this.poolList = poolList;
		this.token = token;
		this.multiNum = multiNum;
		this.countForMustHighQualityUp = countForMustHighQualityUp;
		this.multiGuarantPool = multiGuarantPool;
		this.prdNum = prdNum;
		this.bigGuarantNum = bigGuarantNum;
		this.bigGuarantPool = bigGuarantPool;
		this.milestonePull = milestonePull;
		this.milestoneReward = milestoneReward;
		this.finalGuarantNum = finalGuarantNum;
		this.finalGuarantPool = finalGuarantPool;
		this.isFinalGuarantRepeatable = isFinalGuarantRepeatable;
		this.isFinalGuarantSelectable = isFinalGuarantSelectable;
		this.skipJumpTraverse = skipJumpTraverse;
		this.gachaPoolProbability = gachaPoolProbability;
		this.discountPercent = discountPercent;
		this.discountEligiblePulls = discountEligiblePulls;
		this.maxPulls = maxPulls;
		this.isTenPullOnly = isTenPullOnly;
		this.bgPerfeb = bgPerfeb;
		this.uptestJump = uptestJump;
		this.maxTargetPoint = maxTargetPoint;
		this.targetCharacterPool = targetCharacterPool;
		this.targetCharacterShows = targetCharacterShows;
	}
}
