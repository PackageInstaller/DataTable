using System;

namespace AIScript.Character._16101;

public class SkillScript_Support : SkillAdvancedBase
{
	private const string key_Support = "161_Skill_Sup";

	private const string evt_Summon = "SummonEvt";

	private const string evt_P25Debuff = "P25DebuffEvt";

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
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack("161_Skill_Sup", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("SummonEvt"))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.eventHashCode = Config.summonFWBEvt;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		else if (evt.Equals("P25DebuffEvt"))
		{
			AdventureActorCustomEvent adventureActorCustomEvent2 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent2.sender = _actor;
			adventureActorCustomEvent2.eventHashCode = Config.debuffP25Evt;
			_actor.DispatchEvent(adventureActorCustomEvent2);
		}
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		_skill?.Clear();
	}
}
