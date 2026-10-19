using ACT.Game;

namespace ACT.Config.Condition;

public class CheckIsHaveItemByType : GuideStepCondition
{
	public int Type;

	public override bool CheckCondition()
	{
		return G.localPlayer.Inventory.CheckIsHaveItemByType(Type);
	}
}
