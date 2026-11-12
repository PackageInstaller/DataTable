using System.Collections;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_ChongNengGuangXian : SkillSimpleBase
{
	private bool _cancelChongNeng;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_cancelChongNeng = false;
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
		}
	}

	protected override void OnSkillDisable()
	{
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
		}
		base.OnSkillDisable();
	}

	private void OnCustomEvt(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent { eventName: not null } adventureActorCustomEvent && adventureActorCustomEvent.eventName.Equals("StopEnergyLine"))
		{
			_cancelChongNeng = true;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		AdventureActor entity = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
		BeginLookAtByPos(GetEntityPosition(entity), 0.3, 2000);
		BeginAttack(1, "Chongneng", flushInputedKeys: true);
		while (!_cancelChongNeng)
		{
			yield return WaitTime(0.1f);
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		_actor.DestroySelf();
	}
}
