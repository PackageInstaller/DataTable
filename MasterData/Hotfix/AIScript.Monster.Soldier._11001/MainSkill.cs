using System;

namespace AIScript.Monster.Soldier._11001;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
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
		OnFinish();
	}

	public void OnUpdate()
	{
	}

	private void DoMainLogic()
	{
		LogicEntity attackTarget = _actor.attackTarget;
		if (attackTarget != null)
		{
			_actor.AimAtTarget(attackTarget);
		}
		Action onAnticipationEnd = OnLoopBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnLoopBegin()
	{
	}

	private void OnDashFinish()
	{
		comboAttack?.CancelAttack();
	}
}
