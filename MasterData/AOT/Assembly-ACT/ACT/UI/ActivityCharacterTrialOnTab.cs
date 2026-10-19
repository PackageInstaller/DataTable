using ACT.Model;

namespace ACT.UI;

public class ActivityCharacterTrialOnTab : RedDotDisplayAction
{
	private int activityId = -1;

	public ActivityCharacterTrialOnTab(int activityId)
	{
		comment = "角色试用活动有奖且未领取";
		this.activityId = activityId;
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<ActivityCenterModel>.Interface.GetCharacterTrialRedDotState(activityId);
	}
}
