using ACT.Model;

namespace ACT.UI;

public class ActivitySkinTrialRewardOnTab : RedDotDisplayAction
{
	private int activityId;

	public ActivitySkinTrialRewardOnTab(int activityId)
	{
		this.activityId = activityId;
		comment = "皮肤试用活动有奖且未领取";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<ActivityCenterModel>.Interface.GetSkinTrialRedDotState(activityId);
	}
}
