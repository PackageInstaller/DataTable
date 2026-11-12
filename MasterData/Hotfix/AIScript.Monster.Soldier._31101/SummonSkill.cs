using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._31101;

public class SummonSkill : SkillSimpleBase
{
	private const string comboTag_Dash = "Rush";

	private const string comboTag = "Attack";

	private const string comboTag_Ex = "Attack_EX";

	private const string evt_Attack = "Attack";

	private const string evt_AttackEnd = "End";

	private const string areaEffectAlias = "Area_Attack_End_Soldier";

	private const string areaEffectAlias_Ex = "Area_Attack_End_EX_Soldier";

	private const int checkBuffId = 250106301;

	private static readonly FP dashSpeed = 15;

	private static readonly FP attackDashSpeed = 1;

	private static readonly FP chargeStopDistance = 2;

	private static readonly FP dashMaxDistanceCap = 30;

	private static readonly FP anticipationLookAtDuration = FP.EN1 * 2;

	private static readonly FP anticipationLookAtSpeed = 720;

	private static readonly FP delayDieTime = 0.5f;

	private LogicEntity _target;

	private bool _dashEnded;

	private bool _dashDisabledCollision;

	private string _curAreaEffect;

	private bool _inAttackCombo;

	private bool _attackEventHandled;

	private bool _endEventHandled;

	private bool _hasAttackDash;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_dashDisabledCollision = false;
		_inAttackCombo = false;
		_attackEventHandled = false;
		_endEventHandled = false;
		_hasAttackDash = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		RestoreCollisionIfDisabled();
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
		yield return null;
		_target = _actor.attackTarget;
		string _combo = "Attack";
		_curAreaEffect = "Area_Attack_End_Soldier";
		if (_actor.buffComponent.CheckBuffByBuffID(250106301))
		{
			_combo = "Attack_EX";
			_curAreaEffect = "Area_Attack_End_EX_Soldier";
		}
		yield return StartCoroutine(DoChargeToTarget());
		yield return StartCoroutine(DoAttackWithDash(_combo));
		_actor.EnableCloseBlock();
		yield return _actor.WaitTime(delayDieTime);
		_actor.DestroySelf();
	}

	private IEnumerator DoChargeToTarget()
	{
		BeginAttack(1, "Rush", flushInputedKeys: true, forceInterruptAttack: true);
		if (_target != null && !_target.IsDead())
		{
			BeginLookAt_NotWait(_target, anticipationLookAtDuration, anticipationLookAtSpeed);
		}
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		if (_target == null || _target.IsDead())
		{
			InterruptAttack();
			yield break;
		}
		if (!_actor.ignoreDeterministicCollision)
		{
			_actor.EnableCloseBlock();
			_dashDisabledCollision = true;
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
			if (Distance(GetPosition(), GetEntityPosition(_target)) <= chargeStopDistance)
			{
				StopDash();
				break;
			}
			yield return null;
		}
		RestoreCollisionIfDisabled();
		InterruptAttack();
	}

	private IEnumerator DoAttackWithDash(string comboName)
	{
		_inAttackCombo = true;
		_attackEventHandled = false;
		_endEventHandled = false;
		_hasAttackDash = false;
		BeginAttack(2, comboName, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (_hasAttackDash)
		{
			if (!_dashEnded)
			{
				StopDash();
			}
			RestoreCollisionIfDisabled();
		}
		_inAttackCombo = false;
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (!_inAttackCombo)
		{
			return;
		}
		if (eventName == "Attack")
		{
			if (!_attackEventHandled)
			{
				_attackEventHandled = true;
				TSVector2 position = ((_target != null && !_target.IsDead()) ? GetEntityPosition(_target) : GetPosition());
				PlayAreaEffect(_curAreaEffect, position);
			}
		}
		else
		{
			if (!(eventName == "End") || _endEventHandled)
			{
				return;
			}
			_endEventHandled = true;
			CancelAttack();
			if (_target != null && !_target.IsDead())
			{
				_hasAttackDash = true;
				if (!_actor.ignoreDeterministicCollision)
				{
					_actor.EnableCloseBlock();
					_dashDisabledCollision = true;
				}
				_dashEnded = false;
				FP distance = Distance(GetPosition(), GetEntityPosition(_target)) + dashMaxDistanceCap;
				BeginDashActorForward(2, attackDashSpeed, distance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, FP.EN1);
			}
		}
	}
}
