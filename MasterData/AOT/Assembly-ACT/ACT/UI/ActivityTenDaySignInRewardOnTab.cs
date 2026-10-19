using ACT.Model;

namespace ACT.UI;

public class ActivityTenDaySignInRewardOnTab : RedDotDisplayAction
{
	private int activityId;

	public ActivityTenDaySignInRewardOnTab(int activityId)
	{
		this.activityId = activityId;
		comment = "十日签到活动有奖且未领取";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<ActivityCenterModel>.Interface.GetTenDaySignInRedDotstate(activityId);
	}
}
