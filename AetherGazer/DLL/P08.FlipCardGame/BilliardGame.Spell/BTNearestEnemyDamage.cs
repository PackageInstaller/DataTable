using System.Collections.Generic;
using BilliardGame.Runtime;
using UnityEngine;

namespace BilliardGame.Spell;

public class BTNearestEnemyDamage : BActionNode
{
	public int damage;

	public int num;

	public override BTNodeStatus Run(BTEnv env)
	{
		BilliardGameEntityBase player = env.GetPlayer<BilliardGameEntityBase>("TargetEntity");
		BilliardGameEntityBase billiardGameEntityBase = (env.ContainKey("Caster") ? env.GetPlayer<BilliardGameEntityBase>("Caster") : null);
		if (player is EntityEnemy)
		{
			EntityEnemy entityEnemy = player as EntityEnemy;
			entityEnemy.TakeDamage(damage);
			List<EntityEnemy> nearestEnemyList = BilliardGameLogicManager.Instance.GetNearestEnemyList(entityEnemy.position, num, entityEnemy.entityID);
			for (int i = 0; i < nearestEnemyList.Count; i++)
			{
				nearestEnemyList[i].TakeDamage(damage);
				if (billiardGameEntityBase != null)
				{
					CreateDamageEffect(billiardGameEntityBase.position, nearestEnemyList[i].position);
				}
			}
		}
		return BTNodeStatus.Success;
	}

	private void CreateDamageEffect(Vector3 fromPos, Vector3 toPos)
	{
		float scale = Vector3.Distance(fromPos, toPos) / 3f;
		Vector3 normalized = (toPos - fromPos).normalized;
		float z = Mathf.Atan2(normalized.y, normalized.x) * 57.29578f - 90f;
		Quaternion rotation = Quaternion.Euler(0f, 0f, z);
		BilliardGameLogicManager.Instance.MakeEffectWorld("JueSe/5_1/buff_3003", fromPos, scale, rotation);
	}
}
