using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTSetSelfSpeedNode : BActionNode
{
	public float speed;

	public override BTNodeStatus Run(BTEnv env)
	{
		(env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityPlayer).logic.speedRatio = speed;
		return BTNodeStatus.Success;
	}
}
