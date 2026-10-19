using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ActivityChallengeGroup
{
	public readonly int id;

	public readonly List<ItemKv> challengeCondition;

	public readonly int[] challengeId = new int[0];

	public readonly int stageName;

	public readonly int eventmissionType;

	public readonly int refesh;

	public readonly int limitTimes;

	public readonly int rewardOfferType;

	public readonly int rewardType;

	public readonly int rewardGetType;

	public readonly int[] stageReward = new int[0];

	public readonly long startTimeStamp;

	public readonly long endTimeStamp;

	public readonly int cycleStartTime;

	public ActivityChallengeGroup(int id, List<ItemKv> challengeCondition, int[] challengeId, int stageName, int eventmissionType, int refesh, int limitTimes, int rewardOfferType, int rewardType, int rewardGetType, int[] stageReward, long startTimeStamp, long endTimeStamp, int cycleStartTime)
	{
		this.id = id;
		this.challengeCondition = challengeCondition;
		this.challengeId = challengeId;
		this.stageName = stageName;
		this.eventmissionType = eventmissionType;
		this.refesh = refesh;
		this.limitTimes = limitTimes;
		this.rewardOfferType = rewardOfferType;
		this.rewardType = rewardType;
		this.rewardGetType = rewardGetType;
		this.stageReward = stageReward;
		this.startTimeStamp = startTimeStamp;
		this.endTimeStamp = endTimeStamp;
		this.cycleStartTime = cycleStartTime;
	}
}
