using ACT.Model;

namespace ACT.UI;

public class MapExploreRewardOnSubAreaPanel : RedDotDisplayAction
{
	public int subAreaId;

	public MapExploreRewardOnSubAreaPanel()
	{
		comment = "地图探索度有奖且未领取";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<PlayerModel>.Interface.CheckMapExploreRewardInOtherSubArea(subAreaId);
	}
}
