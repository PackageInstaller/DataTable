using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTEnemyRecoverByHP : BActionNode
{
	public int enemyNum;

	public int recoverRatio;

	public override BTNodeStatus Run(BTEnv env)
	{
		EntityEnemy entityEnemy = env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityEnemy;
		entityEnemy.TakeRegenerationByHpRatio((float)recoverRatio / 100f);
		foreach (EntityEnemy nearestEnemy in BilliardGameLogicManager.Instance.GetNearestEnemyList(entityEnemy.position, enemyNum, entityEnemy.entityID))
		{
			nearestEnemy.TakeRegenerationByHpRatio((float)recoverRatio / 100f);
		}
		return BTNodeStatus.Success;
	}
}
