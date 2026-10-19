using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public static class ShieldConsumer
{
	public static int Consume(AttackData attackData)
	{
		CompAbility compAbility = attackData.attackee.GetCompAbility();
		int actualDamage = attackData.actualDamage;
		if (compAbility.shield <= 0)
		{
			return actualDamage;
		}
		int num = Mathf.Min(compAbility.shield, actualDamage);
		compAbility.ServerSetShield(compAbility.shield - num);
		return actualDamage - num;
	}
}
