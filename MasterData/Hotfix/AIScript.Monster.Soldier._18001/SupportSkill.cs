using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._18001;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "ComboSupport";

	private static readonly FP dashSpeed = 12;

	private static readonly FP dashDistanceExtra = 3;

	private static readonly FP dashDistanceNoTarget = 8;

	private Dash _dash;

	private LogicEntity _target;

	private bool _aborted;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_aborted = false;
		_target = null;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_aborted = true;
		_target = null;
		ILRuntimeAPI.InterruptDash(_dash);
		ILRuntimeAPI.ClearDash(_dash);
		_dash = null;
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
		_aborted = true;
		_skill.Clear();
	}

	public void OnUpdate()
	{
	}

	private void DoMainLogic()
	{
		_target = _actor.attackTarget;
		if (_target != null)
		{
			_actor.soldierAttackTarget = _target;
			_actor.AimAtTarget(_target);
		}
		Action onAnticipationEnd = OnLoopBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("ComboSupport", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnLoopBegin()
	{
		if (!_aborted)
		{
			FP distance;
			if (_target != null && !_target.IsDead())
			{
				_actor.LookAt(_target.tsTransform.Position, 0);
				distance = TSVector2.Distance(_actor.tsTransform.Position, _target.tsTransform.Position) + dashDistanceExtra;
			}
			else
			{
				distance = dashDistanceNoTarget;
			}
			ILRuntimeAPI.BeginDashActorForward(ref _dash, _actor, dashSpeed, distance, 0, OnDashFinish, OnDashFinish, OnDashFinish, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		}
	}

	private void OnDashFinish()
	{
		if (!_aborted)
		{
			comboAttack?.CancelAttack();
		}
	}
}
