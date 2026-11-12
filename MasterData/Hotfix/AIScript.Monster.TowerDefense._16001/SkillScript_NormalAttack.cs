using System;
using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense._16001;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[4];

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	private VisualSmooth smooth;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		smooth = _actor.GetLogicComponent<VisualSmooth>();
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
				smooth?.SyncDeterministicTransform();
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
		ComboInputBuffer.ActionKey[] keys = actionKeys;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnFinish;
		BeginAttack(keys, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}
}
