using System;

namespace AIScript.Monster.Soldier._17001;

public class NormalSkill : SkillAdvancedBase
{
	private const string actionKey = "Attack";

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
		_skill.Clear();
	}

	public void OnUpdate()
	{
		_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
		if (_actor.attackTarget != null)
		{
			LockDirection();
		}
		else
		{
			comboAttack?.CancelAttack();
		}
	}

	private void DoMainLogic()
	{
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Attack", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}
}
