using System;

namespace AIScript.Monster.TowerDefense._12601;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string key = "B2_Skill";

	private string evt_Attack = "126SupportAttack";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private void DoMainLogic()
	{
		string actionTag = key;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (eventName.Equals(evt_Attack))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.eventName = evt_Attack;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}
}
