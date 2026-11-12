using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._145;

public class SummonSkill : SkillAdvancedBase
{
	private const string comboTag = "SummonSkill";

	private const string eventName_End = "End";

	private static readonly FP dashSpeed = 20;

	private static readonly FP dashDuration = 0.5f;

	private readonly List<LogicEntity> _searchEntities = new List<LogicEntity>();

	private Dash _dash;

	private LogicEntity _target;

	private bool _aborted;

	private bool _comboFinished;

	private bool _blockClosed;

	private bool _endHandled;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_target = null;
		_aborted = false;
		_comboFinished = false;
		_blockClosed = false;
		_endHandled = false;
	}

	public void OnStart()
	{
		_target = FindNearestEnemy();
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onInterrupt = OnInterrupt;
		BeginAttack("SummonSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (!_aborted && !_endHandled && string.Equals(eventName, "End"))
		{
			_endHandled = true;
			comboAttack?.CancelAttack();
		}
	}

	private void OnFinish()
	{
		_comboFinished = true;
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_aborted = true;
		ILRuntimeAPI.InterruptDash(_dash);
		ILRuntimeAPI.ClearDash(_dash);
		_dash = null;
		RestoreBlock();
		_target = null;
		_searchEntities.Clear();
		if (_comboFinished)
		{
			_actor.DestroySelf();
		}
	}

	private void OnRecoveryBegin()
	{
		if (!_aborted && !(_target == null) && !_target.IsDead())
		{
			_actor.LookAt(_target.tsTransform.Position, 0);
			CloseBlock();
			FP distance = dashSpeed * dashDuration;
			ILRuntimeAPI.BeginDashActorForward(ref _dash, _actor, dashSpeed, distance, 0, OnDashFinish, OnDashFinish, OnDashFinish, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		}
	}

	private void OnDashFinish()
	{
		if (!_aborted)
		{
			RestoreBlock();
			comboAttack?.CancelAttack();
		}
	}

	private void CloseBlock()
	{
		if (!_blockClosed)
		{
			_blockClosed = true;
			_actor.EnableCloseBlock();
		}
	}

	private void RestoreBlock()
	{
		if (_blockClosed)
		{
			_blockClosed = false;
			_actor.DisableCloseBlock();
		}
	}

	private LogicEntity FindNearestEnemy()
	{
		if (_actor.attackTarget != null && !_actor.attackTarget.IsDead())
		{
			return _actor.attackTarget;
		}
		_searchEntities.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, _actor.actorSearchTargetInfo.monsterSearchRange, isConfront: true, includeSelf: false, _searchEntities);
		for (int i = 0; i < _searchEntities.Count; i++)
		{
			if (_searchEntities.get_Item(i) is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
			{
				return _searchEntities.get_Item(i);
			}
		}
		return null;
	}
}
