using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTAddBossShield : BActionNode
{
	public int num;

	public int reducedamage;

	public override BTNodeStatus Run(BTEnv env)
	{
		(env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityEnemy).TakeBossShield(num, reducedamage);
		return BTNodeStatus.Success;
	}
}
