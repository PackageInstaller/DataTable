using System;
using AIScript.Utils;

namespace AIScript.Character._16001;

public class SkillScript_NormalAttack_Support : SkillAdvancedBase
{
	private bool _havePerk_P24;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_havePerk_P24 = CommonUtils.HavePersonalPerk(_actor.dataID, 516024, out var _);
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	public void OnStart()
	{
		string text = "160_Sup_Shoot";
		if (_havePerk_P24 && _actor.logicVariable.GetLogicTagValue("DecibelState") == 2)
		{
			text = "160_Sup_Perk24";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Event_160_Sup_Shoot"))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config_Support.eventHashCode_TriggerShoot;
			adventureActorCustomEvent.intParam = 2;
			if (_havePerk_P24)
			{
				adventureActorCustomEvent.intParam = 4;
			}
			_actor.DispatchEvent(adventureActorCustomEvent);
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
		_havePerk_P24 = false;
	}
}
