using ACT.Model;

namespace ACT.UI;

public class WorldLevelRewardOnTab : RedDotDisplayAction
{
	public WorldLevelRewardOnTab()
	{
		comment = "世界等级有奖且未领取";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<WorldLevelModel>.Interface.IsShowRedDotInTab();
	}
}
