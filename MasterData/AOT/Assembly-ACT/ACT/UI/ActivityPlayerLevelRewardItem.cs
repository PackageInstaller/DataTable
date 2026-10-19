using ACT.Model;

namespace ACT.UI;

public class ActivityPlayerLevelRewardItem : RedDotDisplayAction
{
	public int activityChallengeId;

	public ActivityPlayerLevelRewardItem()
	{
		comment = "当前等级是否有奖且没领";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<ActivityCenterModel>.Interface.CheckLevelChallengeHasReward(activityChallengeId);
	}
}
