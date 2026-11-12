using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._18001;

public class MainSkill : SkillAdvancedBase
{
	private const string comboTag = "ComboSkill";

	private const string comboTag_Potential2 = "ComboSkill_1";

	private static readonly FP dashBeginTime = 0.7;

	private static readonly FP dashSpeed = 8;

	private static readonly FP dashDistance = 10;

	private static readonly FP dashAngleLimit = 100;

	private static readonly FP turnRotateSpeed = 120;

	private static readonly FP lookAtDurationSlack = 1;

	private int _potentialLv = 1;

	private Dash _dash;

	private LookAtTarget _lookAt;

	private LogicEntity _lookAtTarget;

	private FP _lookAtRemain;

	private LogicEntity _target;

	private bool _aborted;

	private CoroutineNode corDash;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_aborted = false;
		_target = null;
		_lookAtTarget = null;
		_lookAtRemain = 0;
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_aborted = true;
		_target = null;
		_lookAtTarget = null;
		_lookAtRemain = 0;
		ILRuntimeAPI.InterruptDash(_dash);
		ILRuntimeAPI.ClearDash(_dash);
		_dash = null;
		ILRuntimeAPI.StopLookAt(_lookAt);
		ILRuntimeAPI.ClearLookAt(_lookAt);
		_lookAt = null;
		_actor.CancelAiming();
		StopCoroutine(ref corDash);
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
		if (_aborted || _lookAtTarget == null)
		{
			return;
		}
		_lookAtRemain -= _actor.LogicDeltaTime;
		if (_lookAtRemain <= 0)
		{
			_lookAtTarget = null;
			return;
		}
		LogicEntity attackTarget = _actor.attackTarget;
		if (attackTarget != null && attackTarget != _lookAtTarget)
		{
			_target = attackTarget;
			BeginLookAtTarget(_lookAtRemain);
		}
	}

	private void DoMainLogic()
	{
		_target = _actor.attackTarget;
		if (_target == null)
		{
			_target = ((SoldierActor)_actor).FindNearestConfrontTarget();
		}
		if (_target != null)
		{
			_actor.soldierAttackTarget = _target;
			_actor.LookAt(_target.tsTransform.Position, 0);
		}
		string actionTag = ((_potentialLv < 2) ? "ComboSkill" : "ComboSkill_1");
		Action onComboFinish = OnComboFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		StartCoroutine(ref corDash, DoDash());
	}

	private IEnumerator DoDash()
	{
		if (!_aborted)
		{
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(dashBeginTime));
			bool flag = _target != null && !_target.IsDead();
			_actor.CancelAiming();
			ILRuntimeAPI.BeginDashActorForward(ref _dash, _actor, dashSpeed, dashDistance, dashAngleLimit, OnDashFinish, OnDashFinish, OnDashFinish, comboWithAttack: true, flag, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			if (flag)
			{
				BeginLookAtTarget(dashDistance / dashSpeed + lookAtDurationSlack);
			}
		}
	}

	private void BeginLookAtTarget(FP duration)
	{
		if (!(_target == null) && !_target.IsDead() && !(duration <= 0))
		{
			_lookAtTarget = _target;
			_lookAtRemain = duration;
			ILRuntimeAPI.BeginLookAt(ref _lookAt, _actor, _target, duration, turnRotateSpeed, null);
		}
	}

	private void OnDashFinish()
	{
		if (!_aborted)
		{
			ILRuntimeAPI.StopLookAt(_lookAt);
			_lookAtTarget = null;
			_lookAtRemain = 0;
			comboAttack?.CancelAttack();
		}
	}

	private void OnComboFinish()
	{
		OnFinish();
	}
}
