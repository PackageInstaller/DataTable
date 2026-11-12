using AIScript.Utils;

namespace AIScript.Character._12101;

public class ParallelScript_MainControl : ParallelScript
{
	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent, MonsterAdventureActor monster)
	{
		base.OnSelfDamaged(damageEvent, monster);
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.hitDamageTag_Skill_Main))
		{
			_actor.buffComponent.AddBuff(12100001, _actor);
		}
	}
}
