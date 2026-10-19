using ACT.Model;

namespace ACT.UI;

public class Activity35DaySignInRewardOnTab : RedDotDisplayAction
{
	private int activityId;

	public Activity35DaySignInRewardOnTab(int activityId)
	{
		this.activityId = activityId;
		comment = "35日签到活动有奖且未领取";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<ActivityCenterModel>.Interface.Get35DaySignInRedDotstate(activityId);
	}
}
