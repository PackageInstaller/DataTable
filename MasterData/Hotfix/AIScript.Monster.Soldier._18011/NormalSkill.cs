using System;

namespace AIScript.Monster.Soldier._18011;

public class NormalSkill : SkillAdvancedBase
{
	private const string actionKey = "AA";

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

	private void DoMainLogic()
	{
		LogicEntity attackTarget = _actor.attackTarget;
		if (attackTarget != null)
		{
			_actor.soldierAttackTarget = attackTarget;
			_actor.LookAt(attackTarget.tsTransform.Position, 0);
		}
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("AA", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt);
	}
}
