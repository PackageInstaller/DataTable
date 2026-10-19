using ACT.Model;

namespace ACT.UI;

public class PlayerLevelChangedAction : RedDotDisplayAction
{
	public PlayerLevelChangedAction()
	{
		comment = "玩家等级变化";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<PlayerModel>.Interface.CheckHaveLevelReward();
	}
}
