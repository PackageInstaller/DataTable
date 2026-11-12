using System;
using AIScript.Utils;

namespace AIScript.Character._13501;

public class SkillScript_Support : SkillAdvancedBase
{
	private string key_base = "Support_Skill_GhostDoor";

	private string evt_summon = "GhostDoor";

	private int summonId = 13500020;

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

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
		string actionTag = key_base;
		LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, assistantAttackTarget, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_summon))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = summonEvt;
			adventureActorCustomEvent.intParam = summonId;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
