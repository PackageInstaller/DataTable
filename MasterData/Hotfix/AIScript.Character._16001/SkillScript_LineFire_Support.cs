using System;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._16001;

public class SkillScript_LineFire_Support : SkillAdvancedBase
{
	private ISpecialEntity _specialEntity;

	private bool _canLockDirection;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.logicVariable.ToggleLogicTag("CanLineFire_P21", value: false);
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
		_canLockDirection = true;
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("160_Sup_Perk21", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Config.eventHashCode_AddDecibel;
		adventureActorCustomEvent.intParam = 30;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}

	public void OnUpdate()
	{
		LockDirection(_canLockDirection ? default(TSVector2) : _actor.tsTransform.Forward);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "160_Sup_Perk21_BeginLink"))
		{
			_actor.logicVariable.ToggleLogicTag("IsLinkSlotEntity_P21", value: true);
			GameObject fXByAlias = _actor.comboGroup.relatedResourceConfig.GetFXByAlias("Link_Skill_Sup_Perk21");
			if (fXByAlias != null)
			{
				_specialEntity = SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, fXByAlias, _actor.transform.position, _actor.transform.rotation);
			}
		}
		else if (string.Equals(eventName, "160_Sup_Perk21_StopLink"))
		{
			_specialEntity?.Finish();
			_specialEntity = null;
		}
		else if (string.Equals(eventName, "160_Sup_Perk21_StopLockDirection"))
		{
			_canLockDirection = false;
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
		_canLockDirection = false;
		_specialEntity?.Finish();
		_specialEntity = null;
	}
}
