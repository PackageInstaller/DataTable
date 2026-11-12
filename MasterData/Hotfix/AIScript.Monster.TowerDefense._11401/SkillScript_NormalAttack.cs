using System;
using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense._11401;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private string key_Base = "Attack";

	private string key_P04 = "Attack_HighSpeed";

	private int buffId_P04 = 801140030;

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
		string actionTag = (_actor.buffComponent.CheckBuffByBuffID(buffId_P04) ? key_P04 : key_Base);
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnFinish;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}
}
