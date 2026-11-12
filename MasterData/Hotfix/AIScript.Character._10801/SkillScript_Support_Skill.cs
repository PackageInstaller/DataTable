using System;
using AIScript.Utils;

namespace AIScript.Character._10801;

public class SkillScript_Support_Skill : SkillAdvancedBase
{
	private const string actionTag = "B2_Skill";

	private const string eventName_BeginShoot = "ShootStart";

	private LogicEntity _attackTarget;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_attackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		DefaultLookAt();
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("B2_Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	public void OnUpdate()
	{
		if (_attackTarget != null && _attackTarget.IsDead())
		{
			_attackTarget = null;
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "ShootStart"))
		{
			if (_attackTarget == null)
			{
				_attackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
			}
			KasimiraSkillShootEvent kasimiraSkillShootEvent = KasimiraSkillShootEvent.Generate();
			kasimiraSkillShootEvent.sender = _actor;
			kasimiraSkillShootEvent.shootPosition = _actor.tsTransform.Position;
			kasimiraSkillShootEvent.target = _attackTarget;
			ModuleController<AdventureModuleController>.Instance?.DispatchEvent(kasimiraSkillShootEvent);
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
		comboAttack?.Clear();
		_attackTarget = null;
	}
}
