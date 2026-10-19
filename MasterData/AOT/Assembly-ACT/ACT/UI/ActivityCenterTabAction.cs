using ACT.Model;

namespace ACT.UI;

public class ActivityCenterTabAction : RedDotDisplayAction
{
	public ActivityCenterTabAction()
	{
		comment = "活动中心页签";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<ActivityCenterModel>.Interface.GetActivityTabRedpointState();
	}
}
