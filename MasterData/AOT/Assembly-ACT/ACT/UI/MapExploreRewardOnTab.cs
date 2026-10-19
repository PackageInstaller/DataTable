using ACT.Model;

namespace ACT.UI;

public class MapExploreRewardOnTab : RedDotDisplayAction
{
	public int areaId;

	public MapExploreRewardOnTab()
	{
		comment = "地图探索度有奖且未领取";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<PlayerModel>.Interface.CheckMapExploreReward(areaId);
	}
}
