using System;

namespace AIScript.Character._16001;

public class SkillScript_Skill_Support : SkillAdvancedBase
{
	private bool _hasGenerateAreaEffect;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_hasGenerateAreaEffect = false;
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("160_Sup", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		_actor.ReplaceAnimationGroup();
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Event_160_Sup"))
		{
			SendGenerateAreaEffectEvent();
			_hasGenerateAreaEffect = true;
		}
	}

	private void SendGenerateAreaEffectEvent()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Config_Support.eventHashCode_GenerateSkillAreaEffect;
		_actor.DispatchEvent(adventureActorCustomEvent);
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
		if (!_hasGenerateAreaEffect)
		{
			SendGenerateAreaEffectEvent();
		}
		_hasGenerateAreaEffect = false;
	}
}
