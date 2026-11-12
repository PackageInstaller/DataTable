using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._90002;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "Support_1";

	private const string dieTag_base = "Support_1_1";

	private const string dieTag_2Star = "Support_1_2";

	private const string dieTag_3Star = "Support_1_3";

	private static readonly FP dashSpeed = 20;

	private const int selfDestructDamageId = 0;

	private int _potentialLv = 1;

	private Dash _dash;

	private LogicEntity _target;

	private bool _inDiePhase;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_target = null;
		_inDiePhase = false;
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_target = null;
		_inDiePhase = false;
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
		OnFinish();
	}

	public void OnUpdate()
	{
	}

	private void DoMainLogic()
	{
		_target = _actor.attackTarget;
		if (_target != null)
		{
			_actor.AimAtTarget(_target);
		}
		Action onAnticipationEnd = OnLoopBegin;
		Action onComboFinish = OnDashComboFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Support_1", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnLoopBegin()
	{
		if (_target == null || _target.IsDead())
		{
			comboAttack?.CancelAttack();
			return;
		}
		_actor.LookAt(_target.tsTransform.Position, 0);
		FP distance = TSVector2.Distance(_actor.tsTransform.Position, _target.tsTransform.Position);
		ILRuntimeAPI.BeginDashActorForward(ref _dash, _actor, dashSpeed, distance, 0, OnDashFinish, OnDashFinish, OnDashFinish, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void OnDashFinish()
	{
		OnDashComboFinish();
	}

	private void OnDashComboFinish()
	{
		if (_inDiePhase)
		{
			OnFinish();
			return;
		}
		_inDiePhase = true;
		string dieTag = GetDieTag();
		Action onComboFinish = OnDieComboFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(dieTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnDieComboFinish()
	{
		SelfDestruct();
		OnFinish();
	}

	private void SelfDestruct()
	{
		_actor.DestroySelf();
	}

	private string GetDieTag()
	{
		if (_potentialLv >= 3)
		{
			return "Support_1_3";
		}
		if (_potentialLv >= 2)
		{
			return "Support_1_2";
		}
		return "Support_1_1";
	}
}
