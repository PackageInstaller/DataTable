using BilliardGame.Spell;

namespace AINodes;

public class BTPass : BActionNode
{
	public override BTNodeStatus Run(BTEnv env)
	{
		return BTNodeStatus.Success;
	}
}
