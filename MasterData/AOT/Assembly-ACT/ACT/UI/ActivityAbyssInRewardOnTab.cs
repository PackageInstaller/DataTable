using ACT.Model;

namespace ACT.UI;

public class ActivityAbyssInRewardOnTab : RedDotDisplayAction
{
	public ActivityAbyssInRewardOnTab()
	{
		comment = "深渊活动有奖且未领取";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<ActivityCenterModel>.Interface.GetActivityAbyssRedDotState();
	}
}
