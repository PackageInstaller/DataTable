using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTDirectDamage : BActionNode
{
	public int damage;

	public override BTNodeStatus Run(BTEnv env)
	{
		EntityEnemy entityEnemy = env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityEnemy;
		EntityPlayer nearestPlayer = BilliardGameLogicManager.Instance.GetNearestPlayer(entityEnemy.position);
		if (damage <= 0)
		{
			damage = entityEnemy.ATK;
		}
		nearestPlayer?.TakeDamage(damage);
		return BTNodeStatus.Success;
	}
}
