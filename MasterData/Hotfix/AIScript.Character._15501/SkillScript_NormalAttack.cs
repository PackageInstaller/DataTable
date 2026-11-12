using System;
using System.Collections.Generic;

namespace AIScript.Character._15501;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private readonly Dictionary<int, string> dicKey = new Dictionary<int, string>
	{
		[1] = "Attack_1",
		[2] = "Attack_2",
		[3] = "Attack_3",
		[4] = "Attack_4"
	};

	private string evt_atk1 = "Attack_1";

	private string evt_atk2 = "Attack_2";

	private string evt_atk3 = "Attack_3";

	private string evt_atk4 = "Attack_4";

	private int atkEvt = CommonHelper.StringToHash("atkEvt");

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

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	private void DoMainLogic()
	{
		int key = (int)(long)_actor.logicVariable.GetLogicTagValue("curNormalPhase");
		string actionTag = dicKey.get_Item(key);
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_atk1))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.eventHashCode = atkEvt;
			adventureActorCustomEvent.intParam = 1;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		}
		else if (evt.Equals(evt_atk2))
		{
			AdventureActorCustomEvent adventureActorCustomEvent2 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent2.sender = _actor;
			adventureActorCustomEvent2.eventHashCode = atkEvt;
			adventureActorCustomEvent2.intParam = 2;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent2);
		}
		else if (evt.Equals(evt_atk3))
		{
			AdventureActorCustomEvent adventureActorCustomEvent3 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent3.sender = _actor;
			adventureActorCustomEvent3.eventHashCode = atkEvt;
			adventureActorCustomEvent3.intParam = 3;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent3);
		}
		else if (evt.Equals(evt_atk4))
		{
			AdventureActorCustomEvent adventureActorCustomEvent4 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent4.sender = _actor;
			adventureActorCustomEvent4.eventHashCode = atkEvt;
			adventureActorCustomEvent4.intParam = 4;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent4);
		}
	}
}
