using System;

namespace AIScript.Monster.Soldier._18001;

public class NormalSkill : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[2];

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
		LockDirection();
	}

	private void DoMainLogic()
	{
		LogicEntity attackTarget = _actor.attackTarget;
		if (attackTarget != null)
		{
			_actor.soldierAttackTarget = attackTarget;
			_actor.LookAt(attackTarget.tsTransform.Position, 0);
		}
		ComboInputBuffer.ActionKey[] keys = actionKeys;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}
}
