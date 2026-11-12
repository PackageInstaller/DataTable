using System;
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._16001;

public class SkillScript_TorrentialFire_Support : SkillAdvancedBase
{
	private bool _havePerk_P24;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_havePerk_P24 = CommonUtils.HavePersonalPerk(_actor.dataID, 516024, out var _);
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
		foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
		{
			allPlayerActor.buffComponent.AddBuff(16023011, _actor);
		}
	}

	public void OnStart()
	{
		string text = "160_Sup_Perk23";
		if (_havePerk_P24 && _actor.logicVariable.GetLogicTagValue("DecibelState") == 2)
		{
			text = "160_Sup_Perk24Perk23";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Event_160_Sup_P23"))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config_Support.eventHashCode_TriggerShoot;
			adventureActorCustomEvent.intParam = -2;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	public void OnUpdate()
	{
		LockDirection();
		if (_actor.logicVariable.GetLogicTagToggle("FinishTorrentialFire_P23"))
		{
			comboAttack?.CancelAttack();
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
