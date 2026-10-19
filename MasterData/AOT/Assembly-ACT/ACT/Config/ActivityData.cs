using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ActivityData
{
	public readonly int id;

	public readonly int activityName;

	public readonly int activityType;

	public readonly int oneTimetype;

	public readonly int finishcloseTime;

	public readonly int prefabType;

	public readonly int[] activityChallengGroup = new int[0];

	public readonly List<ItemKv> rewardsPreview;

	public readonly List<ItemKv> activityCondition;

	public readonly int activityPrecondition;

	public readonly int openingMethod;

	public readonly string activityJump = "";

	public readonly int shopId;

	public readonly int activityEntryPosition;

	public readonly bool enabled;

	public readonly int sortList;

	public readonly long startTimeStamp;

	public readonly long endTimeStamp;

	public readonly int[] activitySpecialParam = new int[0];

	public readonly int activityIntroduction;

	public readonly int activityDesc;

	public readonly List<ItemKv> lotteryId;

	public readonly bool skipJumpTraverse;

	public readonly int compensationMail;

	public readonly int loopType;

	public readonly int expirationReminderEmail;

	public ActivityData(int id, int activityName, int activityType, int oneTimetype, int finishcloseTime, int prefabType, int[] activityChallengGroup, List<ItemKv> rewardsPreview, List<ItemKv> activityCondition, int activityPrecondition, int openingMethod, string activityJump, int shopId, int activityEntryPosition, bool enabled, int sortList, long startTimeStamp, long endTimeStamp, int[] activitySpecialParam, int activityIntroduction, int activityDesc, List<ItemKv> lotteryId, bool skipJumpTraverse, int compensationMail, int loopType, int expirationReminderEmail)
	{
		this.id = id;
		this.activityName = activityName;
		this.activityType = activityType;
		this.oneTimetype = oneTimetype;
		this.finishcloseTime = finishcloseTime;
		this.prefabType = prefabType;
		this.activityChallengGroup = activityChallengGroup;
		this.rewardsPreview = rewardsPreview;
		this.activityCondition = activityCondition;
		this.activityPrecondition = activityPrecondition;
		this.openingMethod = openingMethod;
		this.activityJump = activityJump;
		this.shopId = shopId;
		this.activityEntryPosition = activityEntryPosition;
		this.enabled = enabled;
		this.sortList = sortList;
		this.startTimeStamp = startTimeStamp;
		this.endTimeStamp = endTimeStamp;
		this.activitySpecialParam = activitySpecialParam;
		this.activityIntroduction = activityIntroduction;
		this.activityDesc = activityDesc;
		this.lotteryId = lotteryId;
		this.skipJumpTraverse = skipJumpTraverse;
		this.compensationMail = compensationMail;
		this.loopType = loopType;
		this.expirationReminderEmail = expirationReminderEmail;
	}
}
