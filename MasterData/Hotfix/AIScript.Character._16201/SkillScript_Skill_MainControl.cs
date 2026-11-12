using System;
using AIScript.Utils;

namespace AIScript.Character._16201;

public class SkillScript_Skill_MainControl : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516202, out var _))
		{
			_actor.logicVariable.ToggleLogicTag("CanBindExtraSkill_P2", value: false);
		}
	}

	public void OnStart()
	{
		string text = "Skill_Main1";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516201, out var _))
		{
			text = "Skill_Main1_P1";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onActivationEnd = OnRapierActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
	}

	private void OnRapierActivationEnd()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516202, out var _))
		{
			_actor.logicVariable.ToggleLogicTag("CanBindExtraSkill_P2", value: true);
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill_Main2", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	private void OnCustomEvent(string eventName)
	{
		int perkLevel;
		if (string.Equals(eventName, "162SkilMainZhongJianFall"))
		{
			TriggerLightingSword();
		}
		else if (string.Equals(eventName, "162SkillMainJianQi"))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516201, out perkLevel))
			{
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.sender = _actor;
				adventureActorCustomEvent.actor = _actor;
				adventureActorCustomEvent.eventHashCode = Config.eventHashCode_TriggerSowrdAura;
				adventureActorCustomEvent.intParam = 162310005;
				_actor.DispatchEvent(adventureActorCustomEvent);
			}
		}
		else if (string.Equals(eventName, "162P3") && CommonUtils.HavePersonalPerk(_actor.dataID, 516203, out perkLevel))
		{
			TriggerLightingSword();
		}
	}

	private void TriggerLightingSword()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_TriggerLightingSword;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516202, out var _))
		{
			_actor.logicVariable.ToggleLogicTag("CanBindExtraSkill_P2", value: true);
		}
	}
}
