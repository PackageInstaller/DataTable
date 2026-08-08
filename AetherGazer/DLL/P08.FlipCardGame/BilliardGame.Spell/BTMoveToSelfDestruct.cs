using BilliardGame.Runtime;
using UnityEngine;

namespace BilliardGame.Spell;

public class BTMoveToSelfDestruct : BActionNode
{
	public int buffID;

	public float moveTime = 1f;

	public override BTNodeStatus Run(BTEnv env)
	{
		EntityEnemy enemy = env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityEnemy;
		EntityPlayer player = BilliardGameLogicManager.Instance.GetNearestPlayer(enemy.position);
		Physics2D.IgnoreCollision(enemy.logic.GetEnemyCol(), player.logic.GetPlayerCol(), ignore: true);
		enemy.DoMove(player.position, moveTime, delegate
		{
			enemy.SuppressDamageHud = true;
			enemy.TakeDamage(99999);
			BilliardGameSpellManager.Instance.CastBuff(buffID, enemy);
			Physics2D.IgnoreCollision(enemy.logic.GetEnemyCol(), player.logic.GetPlayerCol(), ignore: false);
		});
		return BTNodeStatus.Success;
	}
}
