using ACT.Model;

namespace ACT.UI;

public class ActivityDailyLotteryOnTab : RedDotDisplayAction
{
	public ActivityDailyLotteryOnTab()
	{
		comment = "清剿活动有奖且未领取";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<ActivityCenterModel>.Interface.CheckDailyLotteryHasReward();
	}
}
