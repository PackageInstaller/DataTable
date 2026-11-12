using System.Collections;
using TrueSync;

namespace AIScript.Monster.Soldier._31101;

public class MainSkill : SkillSimpleBase
{
	private const string comboTag_Charge1 = "MainSkill_1";

	private const string comboTag_Attack = "MainSkill_Wait";

	private const string comboTag_Charge2 = "MainSkill_2";

	private const string comboTagUltra = "MainSkill_Finish";

	private const string ultraEvent_Attack = "Attack";

	private const string ultraAreaEffectAlias = "Area_MainSkill_Finish_Soldier";

	private static readonly FP dashSpeed = 40;

	private static readonly FP chargeStopDistance = 1;

	private static readonly FP dashMaxDistanceCap = 30;

	private static readonly FP attackDuration = FP.EN1 * 5;

	private static readonly FP ultraLinkDuration = FP.EN1 * 8;

	private static readonly FP ultraLoopHoldDuration = FP.EN1 * 18;

	private static readonly FP attackTurnSpeed = 720;

	private static readonly FP anticipationLookAtDuration = FP.EN1 * 2;

	private static readonly FP anticipationLookAtSpeed = 720;

	private const int dashTimes = 2;

	private const int dashTimesBonus_3 = 2;

	private LogicEntity _target;

	private int _potentialLv = 1;

	private bool _dashEnded;

	private bool _inUltraCombo;

	private bool _ultraAttackHandled;

	private bool _dashDisabledCollision;

	public new void OnStart()
	{
		StartCor(RunMainAndFinish());
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
	}

	private IEnumerator RunMainAndFinish()
	{
		yield return StartCor(DoMainLogic());
		_skill.Clear();
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
		_dashDisabledCollision = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		RestoreCollisionIfDisabled();
		_actor.CancelAiming();
	}

	private void RestoreCollisionIfDisabled()
	{
		if (_dashDisabledCollision)
		{
			_dashDisabledCollision = false;
			_actor.DisableCloseBlock();
			if (_actor != null)
			{
				_actor.ignoreDeterministicCollision = false;
			}
		}
	}

	protected override void OnDashFinish(int index)
	{
		_dashEnded = true;
	}

	protected override void DashFinishByActor(int index)
	{
		_dashEnded = true;
	}

	protected override void DashFinishByObstacle(int index)
	{
		_dashEnded = true;
	}

	protected override void DashFinishByFriend(int index)
	{
		_dashEnded = true;
	}

	protected override IEnumerator DoMainLogic()
	{
		RefreshTarget();
		int totalCharges = 2 + ((_potentialLv >= 3) ? 2 : 0);
		yield return StartCor(DoChargeCombo(1, "MainSkill_1"));
		for (int i = 1; i < totalCharges; i++)
		{
			if (_target == null || _target.IsDead())
			{
				RefreshTarget();
			}
			yield return StartCor(DoAttackWithTurn(i * 2, "MainSkill_Wait", attackDuration));
			if (_target == null || _target.IsDead())
			{
				RefreshTarget();
			}
			yield return StartCor(DoChargeCombo(i * 2 + 1, "MainSkill_2"));
		}
		if (_potentialLv >= 3)
		{
			if (_target == null || _target.IsDead())
			{
				RefreshTarget();
			}
			yield return StartCor(DoAttackWithTurn(totalCharges * 2 + 1, "MainSkill_Wait", ultraLinkDuration));
			if (_target == null || _target.IsDead())
			{
				RefreshTarget();
			}
			yield return StartCor(DoUltraCombo(totalCharges * 2 + 2));
		}
	}

	private IEnumerator DoUltraCombo(int comboIndex)
	{
		_inUltraCombo = true;
		_ultraAttackHandled = false;
		BeginAttack(comboIndex, "MainSkill_Finish", flushInputedKeys: true, forceInterruptAttack: true);
		if (_target != null && !_target.IsDead())
		{
			BeginLookAt_NotWait(_target, anticipationLookAtDuration, anticipationLookAtSpeed);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		_inUltraCombo = false;
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (_inUltraCombo && !(eventName != "Attack") && !_ultraAttackHandled)
		{
			_ultraAttackHandled = true;
			TSVector2 tSVector = ((_target != null && !_target.IsDead()) ? GetEntityPosition(_target) : GetPosition());
			SetHideModelEnable();
			_actor.EnableCloseBlock();
			_actor.ignoreDeterministicCollision = true;
			Teleport(tSVector, checkPositionReachable: false);
			PlayAreaEffect("Area_MainSkill_Finish_Soldier", tSVector, GetRotation());
			StartCor(UltraLoopHoldAndFinish());
		}
	}

	private IEnumerator UltraLoopHoldAndFinish()
	{
		yield return WaitTime(ultraLoopHoldDuration);
		SetHideModelDisable();
		_actor.DisableCloseBlock();
		if (_actor != null)
		{
			_actor.ignoreDeterministicCollision = false;
		}
		CancelAttack();
	}

	private IEnumerator DoChargeCombo(int comboIndex, string comboTag)
	{
		BeginAttack(comboIndex, comboTag, flushInputedKeys: true, forceInterruptAttack: true);
		if (_target != null && !_target.IsDead())
		{
			BeginLookAt_NotWait(_target, anticipationLookAtDuration, anticipationLookAtSpeed);
		}
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		if (_target == null || _target.IsDead())
		{
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield break;
		}
		_dashEnded = false;
		FP distance = Distance(GetPosition(), GetEntityPosition(_target)) + dashMaxDistanceCap;
		BeginDashActorForward(1, dashSpeed, distance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, FP.EN1);
		while (!_dashEnded)
		{
			if (_target == null || _target.IsDead())
			{
				StopDash();
				break;
			}
			if (Distance(GetPosition(), GetEntityPosition(_target)) <= _target.GetRadius() + chargeStopDistance)
			{
				StopDash();
				break;
			}
			yield return null;
		}
		if (!_actor.ignoreDeterministicCollision)
		{
			_actor.EnableCloseBlock();
			_actor.ignoreDeterministicCollision = true;
			_dashDisabledCollision = true;
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		RestoreCollisionIfDisabled();
	}

	private IEnumerator DoAttackWithTurn(int comboIndex, string comboTag, FP duration)
	{
		BeginAttack(comboIndex, comboTag, flushInputedKeys: true, forceInterruptAttack: true);
		if (_target != null && !_target.IsDead())
		{
			BeginLookAt_NotWait(_target, duration, attackTurnSpeed);
		}
		yield return WaitTime(duration);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void RefreshTarget()
	{
		_target = _actor.attackTarget;
		if (_target == null || _target.IsDead())
		{
			_target = ((SoldierActor)_actor).FindNearestConfrontTarget();
		}
	}
}
