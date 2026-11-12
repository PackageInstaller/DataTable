using System;
using UnityEngine;

namespace AIScript.Character._16001;

public class SkillScript_RotateFire_Support : SkillAdvancedBase
{
	private ISpecialEntity _specialEntity;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Config.eventHashCode_RemoveDecibel;
		adventureActorCustomEvent.boolParam = false;
		adventureActorCustomEvent.intParam = 40;
		_actor.DispatchEvent(adventureActorCustomEvent);
		LockDirection(_actor.tsTransform.Forward);
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("160_Sup_Perk22", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "160_Sup_Perk22_BeginLink"))
		{
			_actor.logicVariable.ToggleLogicTag("IsLinkSlotEntity_P22", value: true);
			GameObject fXByAlias = _actor.comboGroup.relatedResourceConfig.GetFXByAlias("Link_Skill_Sup_Perk_22");
			if (fXByAlias != null)
			{
				_specialEntity = SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, fXByAlias, _actor.transform.position, _actor.transform.rotation);
			}
		}
		else if (string.Equals(eventName, "160_Sup_Perk22_StopLink"))
		{
			_specialEntity?.Finish();
			_specialEntity = null;
		}
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		CancelLockDirection();
		_specialEntity?.Finish();
		_specialEntity = null;
	}
}
