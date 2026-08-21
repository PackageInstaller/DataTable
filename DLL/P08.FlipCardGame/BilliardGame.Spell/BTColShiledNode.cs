using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTColShiledNode : BActionNode
{
	public int num;

	public override BTNodeStatus Run(BTEnv env)
	{
		(env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityEnemy).TakeColShield(num);
		return BTNodeStatus.Success;
	}
}
