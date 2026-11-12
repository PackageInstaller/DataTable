using System;
using AIScript.Utils;

namespace AIScript.Character._15701;

public class SkillScript_Skill_MainControl : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt();
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill_Main", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "BaTiStart"))
		{
			_actor.buffComponent.AddBuff(1004, _actor);
		}
		else if (string.Equals(eventName, "154MainShot"))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_SkillShoot;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		else if (string.Equals(eventName, "BaTiEnd"))
		{
			_actor.buffComponent.RemoveBuffByBuffId(1004);
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
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515702, out var _))
		{
			_actor.buffComponent.AddBuff(15702011, _actor);
		}
		_actor.buffComponent.RemoveBuffByBuffId(1004);
	}
}
