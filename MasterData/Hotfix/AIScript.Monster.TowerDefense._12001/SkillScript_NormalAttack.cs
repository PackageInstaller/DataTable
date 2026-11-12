using System;
using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense._12001;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private ComboInputBuffer.ActionKey[] actionKey = new ComboInputBuffer.ActionKey[5];

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		aimTarget.Cancel();
		targetEntity = null;
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			if (targetEntity != _actor.attackTarget)
			{
				targetEntity = _actor.attackTarget;
				aimTarget.Cancel();
				aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
			}
		}
		else
		{
			_actor.CancelAttack();
		}
	}

	private void DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
		ComboInputBuffer.ActionKey[] keys = actionKey;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnFinish;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}
}
