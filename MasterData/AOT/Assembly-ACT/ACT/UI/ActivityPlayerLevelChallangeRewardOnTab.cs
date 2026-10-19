using ACT.Model;

namespace ACT.UI;

public class ActivityPlayerLevelChallangeRewardOnTab : RedDotDisplayAction
{
	public ActivityPlayerLevelChallangeRewardOnTab()
	{
		comment = "玩家等级活动有奖且未领取";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<ActivityCenterModel>.Interface.PlayerLevelHasReward();
	}
}
