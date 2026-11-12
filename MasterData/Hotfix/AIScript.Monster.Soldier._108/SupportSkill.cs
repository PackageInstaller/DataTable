using System;

namespace AIScript.Monster.Soldier._108;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Support";

	private readonly string eventName_BeginShoot = "ShootStart";

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).soldierAI?.FindNearestConfrontTarget();
		}
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_BeginShoot))
		{
			KasimiraSkillShootEvent kasimiraSkillShootEvent = KasimiraSkillShootEvent.Generate();
			kasimiraSkillShootEvent.sender = _actor;
			kasimiraSkillShootEvent.shootPosition = _actor.tsTransform.Position;
			kasimiraSkillShootEvent.target = _actor.attackTarget;
			ModuleController<AdventureModuleController>.Instance?.DispatchEvent(kasimiraSkillShootEvent);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}
}
