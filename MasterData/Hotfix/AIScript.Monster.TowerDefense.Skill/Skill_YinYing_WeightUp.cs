using System.Collections;

namespace AIScript.Monster.TowerDefense.Skill;

public class Skill_YinYing_WeightUp : SkillSimpleBase
{
	private long HurtAmount;

	private bool IsInterrupted;

	protected override void OnSkillEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnRecieveDamage);
		HurtAmount = 0L;
		SetLogicTagToggleValue(_actor, "IsHurtInterrupted", value: false);
	}

	protected override void OnSkillDisable()
	{
		RemoveBuffFromTarget(_actor, 807010210);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnRecieveDamage);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "Skill", flushInputedKeys: true, forceInterruptAttack: true);
		AddBuffToTarget(_actor, 807010210);
		while (!GetLogicTagToggleValue(_actor, "IsHurtInterrupted"))
		{
			yield return null;
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}

	protected void OnRecieveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.to.Id)
		{
			HurtAmount += adventureActorReceiveDamageEvent.damage;
			if ((double)HurtAmount >= (double)_actor.actorHealthInfo.hpMax * 0.3)
			{
				SetLogicTagToggleValue(_actor, "IsHurtInterrupted", value: true);
			}
		}
	}
}
