using ACT.Model;

namespace ACT.UI;

public class SystemGuideRewardOnTab : RedDotDisplayAction
{
	public SystemGuideRewardOnTab()
	{
		comment = "系统引导有奖且未领取";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<PlayerModel>.Interface.CheckHaveChapterReward();
	}
}
