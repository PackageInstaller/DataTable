using ACT.Model;

namespace ACT.UI;

public class ActivitySevenDaySignInRewardOnTab : RedDotDisplayAction
{
	private int activityId;

	public ActivitySevenDaySignInRewardOnTab(int activityId)
	{
		this.activityId = activityId;
		comment = "七日签到活动有奖且未领取";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<ActivityCenterModel>.Interface.GetSevenDayRedDotState(activityId);
	}
}
