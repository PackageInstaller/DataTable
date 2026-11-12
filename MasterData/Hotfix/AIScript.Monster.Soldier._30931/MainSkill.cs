using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._30931;

public class MainSkill : SkillAdvancedBase
{
	private const string comboTag = "MainSkill";

	private static readonly FP dashSpeed = 50;

	private static readonly FP dashDistanceExtra = 3;

	private static readonly FP turnDuration = FP.EN2 * 15;

	private static readonly FP turnRotateSpeed = 1200;

	private const string comboTag_3 = "MainSkill_P2";

	private const string eventName_HammerEnd_Long = "HammerEnd_Long";

	private const string eventName_HammerEnd_Short = "HammerEnd_Short";

	private const int BuffId_HammerEnd_Long = 250106401;

	private const int BuffId_HammerEnd_Short = 250106402;

	private Dash _dash;

	private LookAtTarget _lookAt;

	private AdventureActor _target;

	private bool _aborted;

	private bool _dashDisabledCollision;

	private readonly List<LogicEntity> _searchBuffer = new List<LogicEntity>();

	private int PotentialLv = 1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_aborted = false;
		_target = null;
		_dashDisabledCollision = false;
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_aborted = true;
		_target = null;
		RestoreCollisionIfDisabled();
		ILRuntimeAPI.InterruptDash(_dash);
		ILRuntimeAPI.ClearDash(_dash);
		_dash = null;
		ILRuntimeAPI.StopLookAt(_lookAt);
		ILRuntimeAPI.ClearLookAt(_lookAt);
		_lookAt = null;
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
		_target = FindFarthestConfrontTarget();
		if (_target != null)
		{
			_actor.attackTarget = _target;
			_actor.soldierAttackTarget = _target;
			_actor.AimAtTarget(_target);
		}
		string actionTag = ((PotentialLv >= 3) ? "MainSkill_P2" : "MainSkill");
		Action onAnticipationEnd = OnDashBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		Action<string> action = onCustomEvent;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, action);
	}

	private void OnDashBegin()
	{
		if (_aborted)
		{
			return;
		}
		if (_target == null || _target.IsDead())
		{
			comboAttack?.CancelAttack();
			return;
		}
		_actor.LookAt(_target.tsTransform.Position, 0);
		FP distance = TSVector2.Distance(_actor.tsTransform.Position, _target.tsTransform.Position) + dashDistanceExtra;
		if (!_actor.ignoreDeterministicCollision)
		{
			_actor.EnableCloseBlock();
			_dashDisabledCollision = true;
		}
		ILRuntimeAPI.BeginDashActorForward(ref _dash, _actor, dashSpeed, distance, 0, OnDashFinish, OnDashFinish, OnDashFinish, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void OnDashFinish()
	{
		RestoreCollisionIfDisabled();
		if (!_aborted)
		{
			comboAttack?.CancelAttack();
			if (_target != null && !_target.IsDead())
			{
				ILRuntimeAPI.BeginLookAt(ref _lookAt, _actor, _target, turnDuration, turnRotateSpeed, null);
			}
		}
	}

	private void RestoreCollisionIfDisabled()
	{
		if (_dashDisabledCollision)
		{
			_actor.DisableCloseBlock();
			if (_actor != null)
			{
				_actor.ignoreDeterministicCollision = false;
			}
		}
	}

	private AdventureActor FindFarthestConfrontTarget()
	{
		_searchBuffer.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, _actor.actorSearchTargetInfo.monsterSearchRange, isConfront: true, includeSelf: false, _searchBuffer);
		for (int num = _searchBuffer.Count - 1; num >= 0; num--)
		{
			if (_searchBuffer.get_Item(num) is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
			{
				return adventureActor;
			}
		}
		return null;
	}

	private void onCustomEvent(string evt)
	{
		if (PotentialLv < 3)
		{
			return;
		}
		if (string.Equals(evt, "HammerEnd_Long"))
		{
			if (_actor.buffComponent.CheckBuffByBuffID(250106401))
			{
				_actor.buffComponent.RemoveBuffByBuffId(250106401);
			}
		}
		else if (string.Equals(evt, "HammerEnd_Short") && _actor.buffComponent.CheckBuffByBuffID(250106402))
		{
			_actor.buffComponent.RemoveBuffByBuffId(250106402);
		}
	}
}
