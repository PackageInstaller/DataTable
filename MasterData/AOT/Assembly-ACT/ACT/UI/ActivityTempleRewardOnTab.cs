using ACT.Model;

namespace ACT.UI;

public class ActivityTempleRewardOnTab : RedDotDisplayAction
{
	public ActivityTempleRewardOnTab()
	{
		comment = "神庙活动有奖且未领取";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<ActivityTempleChallengeModel>.Interface.GetActivityRedpointState();
	}
}
