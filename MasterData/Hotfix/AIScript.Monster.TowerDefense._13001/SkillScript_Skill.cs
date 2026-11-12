using System;

namespace AIScript.Monster.TowerDefense._13001;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string key = "Skill";

	private string evt_summon = "Summon";

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

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
		Action<string> action = onCustomEvent;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	protected void onCustomEvent(string eventName)
	{
		if (eventName.Equals(evt_summon))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.eventHashCode = summonEvt;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}
}
