using ACT.Model;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public static class PostureDamageResolver
{
	public static void Apply(AttackData attackData, Ability ability)
	{
		CompAbility compAbility = attackData.attackee.GetCompAbility();
		int num = (compAbility.IsHavePosture ? compAbility.posture : 0);
		if (compAbility.IsHavePosture)
		{
			compAbility.ServerSetPosture(compAbility.posture - Mathf.CeilToInt(attackData.postureDamage), attackData.attacker.GetCompAbility().GetProperty(207u).value);
		}
		int posture = compAbility.posture;
		if (Model<ChallengeTargetTrackerModel>.HasInstance() && Model<ChallengeTargetTrackerModel>.Interface.NeedPostureDamageEvent)
		{
			Model<ChallengeTargetTrackerModel>.Interface.OnPostureDamage(attackData, num, posture);
		}
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtPostureDamage evt = abilitySystem.GetEvt<EvtPostureDamage>(attackData.directAttacker, ability);
		evt.mainEntity = attackData.attacker;
		evt.attackData = attackData;
		evt.beforePosture = num;
		evt.afterPosture = posture;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
	}
}
