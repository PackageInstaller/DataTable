using System;

namespace AIScript.Character._12601;

public class SkillScript_MainControl_S2 : SkillAdvancedBase
{
	private readonly string key_Base = "B1_Skill_P02";

	private readonly string evt_Return = "126_B1_HatReturn";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	private void Clear()
	{
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
		string actionTag = key_Base;
		LogicEntity attackTarget = _actor.attackTarget;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, attackTarget, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_Return))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventName = evt_Return;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
