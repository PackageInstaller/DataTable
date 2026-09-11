using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTAddShieldByHp : BActionNode
{
	public int enemyNum;

	public int shieldRatio;

	public override BTNodeStatus Run(BTEnv env)
	{
		EntityEnemy entityEnemy = env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityEnemy;
		entityEnemy.TakeShieldByHpRatio((float)shieldRatio / 100f);
		foreach (EntityEnemy nearestEnemy in BilliardGameLogicManager.Instance.GetNearestEnemyList(entityEnemy.position, enemyNum, entityEnemy.entityID))
		{
			nearestEnemy.TakeShieldByHpRatio((float)shieldRatio / 100f);
		}
		return BTNodeStatus.Success;
	}
}
