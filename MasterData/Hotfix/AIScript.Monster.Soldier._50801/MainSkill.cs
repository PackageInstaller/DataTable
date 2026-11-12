using System;
using TrueSync;

namespace AIScript.Monster.Soldier._50801;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill";

	private static readonly FP loopDurationSec1Star = 3;

	private static readonly FP loopDurationSec2Star = 5;

	private static readonly FP loopDurationSec3Star = 10;

	private readonly FP FollowStopRange = 1;

	private LogicEntity _target;

	private int _potentialLv = 1;

	private bool _looping;

	private FP _loopTimer;

	private bool _moving;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
		_target = null;
		_looping = false;
		_loopTimer = 0;
		_moving = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_looping = false;
		_moving = false;
		_target = null;
		_actor.InterruptMovement();
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
		if (!_looping)
		{
			return;
		}
		if (_target == null || _target.IsDead())
		{
			_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
			if (_actor.attackTarget == null)
			{
				EndLoop();
				return;
			}
			_target = _actor.attackTarget;
			_actor.soldierAttackTarget = _target;
			_actor.CancelAiming();
			_actor.AimAtTarget(_target);
		}
		if (FollowStopRange > 0 && _actor.DistanceWithRadius(_target) > FollowStopRange)
		{
			if (!_moving)
			{
				_moving = true;
				if (!_actor.TrackMove(_target, FollowStopRange, enableNavigation: false, NavAgentTypeNames.NavigationUpdateQualityLevel.LowQualityNavigationUpdate, AdventureActor.MovementMode.Run, () =>
				{
					_moving = false;
				}, () =>
				{
					_moving = false;
				}))
				{
					_moving = false;
				}
			}
		}
		else
		{
			if (_moving)
			{
				_moving = false;
				_actor.InterruptMovement();
			}
			_actor.AimAtTarget(_target);
		}
		_loopTimer -= _actor.LogicDeltaTime;
		if (_loopTimer <= 0)
		{
			EndLoop();
		}
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
		BeginAttack("Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnLoopBegin()
	{
		_looping = true;
		_loopTimer = GetLoopDurationByStar(_potentialLv);
	}

	private FP GetLoopDurationByStar(int potentialLv)
	{
		return potentialLv switch
		{
			2 => loopDurationSec2Star, 
			3 => loopDurationSec3Star, 
			_ => loopDurationSec1Star, 
		};
	}

	private void EndLoop()
	{
		if (_looping)
		{
			_looping = false;
			if (_moving)
			{
				_moving = false;
				_actor.InterruptMovement();
			}
			comboAttack?.CancelAttack();
		}
	}
}
