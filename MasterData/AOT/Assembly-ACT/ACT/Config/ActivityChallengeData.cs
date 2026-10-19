using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ActivityChallengeData
{
	public readonly int id;

	public readonly int challengeText;

	public readonly int missionGroupId;

	public readonly int refesh;

	public readonly int times;

	public readonly int challengeCondition;

	public readonly int[] challengeConditionParm = new int[0];

	public readonly int rewardType;

	public readonly int rewardGetType;

	public readonly int[] challengeReward = new int[0];

	public readonly List<ItemKv> rewardsPreview;

	public readonly List<ItemKv> lotteryRewards;

	public readonly bool challengeLoop;

	public readonly int activityId;

	public readonly int[] challengeJump = new int[0];

	public readonly int extraType;

	public readonly int[] extraParm = new int[0];

	public readonly int cycleStartTime;

	public readonly List<ItemKv> cost;

	public ActivityChallengeData(int id, int challengeText, int missionGroupId, int refesh, int times, int challengeCondition, int[] challengeConditionParm, int rewardType, int rewardGetType, int[] challengeReward, List<ItemKv> rewardsPreview, List<ItemKv> lotteryRewards, bool challengeLoop, int activityId, int[] challengeJump, int extraType, int[] extraParm, int cycleStartTime, List<ItemKv> cost)
	{
		this.id = id;
		this.challengeText = challengeText;
		this.missionGroupId = missionGroupId;
		this.refesh = refesh;
		this.times = times;
		this.challengeCondition = challengeCondition;
		this.challengeConditionParm = challengeConditionParm;
		this.rewardType = rewardType;
		this.rewardGetType = rewardGetType;
		this.challengeReward = challengeReward;
		this.rewardsPreview = rewardsPreview;
		this.lotteryRewards = lotteryRewards;
		this.challengeLoop = challengeLoop;
		this.activityId = activityId;
		this.challengeJump = challengeJump;
		this.extraType = extraType;
		this.extraParm = extraParm;
		this.cycleStartTime = cycleStartTime;
		this.cost = cost;
	}
}
