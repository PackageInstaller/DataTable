using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行架势伤害", "Action", new string[] { "posture", "damage", "hit", "attack" })]
public class ActionPostureDamage : ConfigAction
{
	public float postureDamage;

	public override void Do(ActionMemory memory)
	{
		CompAbility compAbility = memory.target.entity.GetCompAbility();
		if (compAbility.IsHavePosture)
		{
			int value = compAbility.posture - Mathf.CeilToInt(postureDamage);
			compAbility.ServerSetPosture(value);
		}
	}
}
