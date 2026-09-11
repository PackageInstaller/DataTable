using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTAddFoodNode : BActionNode
{
	public int food;

	public override BTNodeStatus Run(BTEnv env)
	{
		BilliardGameLogicManager.Instance.Food += food;
		return BTNodeStatus.Success;
	}
}
