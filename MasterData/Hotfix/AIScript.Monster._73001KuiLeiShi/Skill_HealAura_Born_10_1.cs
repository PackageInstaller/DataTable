using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_HealAura_Born_10_1 : SkillSimpleBase
{
	private LogicEntity Targetenemy;

	private readonly string combo_key1 = "Buff";

	private string tag1 = "Mark1";

	private bool _finalStarted;

	private int _deathCount;

	protected override void OnSkillEnable()
	{
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
	}

	private void OnCustomEvt(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent { eventName: not null } adventureActorCustomEvent && adventureActorCustomEvent.eventName.Equals("OnCustomEvt"))
		{
			ClearActors(new List<LogicEntity> { _actor });
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		PlayAreaEffect("Area_72014_RenOu_Shiti_10_1", GetPosition());
		yield return WaitTime(999999);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
