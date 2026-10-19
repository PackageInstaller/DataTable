using ACT.Utility;

namespace ACT.UI;

public class ActivityCharacterExploreChallengeOnTab : RedDotDisplayAction
{
	public ActivityCharacterExploreChallengeOnTab()
	{
		comment = "探索综合活动有奖且未领取";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return GameUtility.GetExploreChallengeRedDotState();
	}
}
