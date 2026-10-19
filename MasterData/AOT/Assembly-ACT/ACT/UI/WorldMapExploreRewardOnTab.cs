using ACT.Model;

namespace ACT.UI;

public class WorldMapExploreRewardOnTab : RedDotDisplayAction
{
	public WorldMapExploreRewardOnTab()
	{
		comment = "世界地图显示红点奖励";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<PlayerModel>.Interface.CheckMapExploreReward();
	}
}
