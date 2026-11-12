using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._90002;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill";

	private const string fireEvent = "Fire";

	private const string bulletPath = "Bullet";

	private static readonly FP bulletHeight = 1.8;

	private static readonly FP bulletRange = 10;

	private static readonly FP loopDuration = 0;

	private LogicEntity _target;

	private bool _looping;

	private FP _loopTimer;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_target = null;
		_looping = false;
		_loopTimer = 0;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_target = null;
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
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		_loopTimer -= _actor.LogicDeltaTime;
		if (_loopTimer <= 0 && _looping)
		{
			comboAttack?.CancelAttack();
		}
	}

	private void DoMainLogic()
	{
		_target = _actor.attackTarget;
		if (_target != null)
		{
			_actor.AimAtTarget(_target);
		}
		Action onAnticipationEnd = OnLoopBegin;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("Fire"))
		{
			ShootBullet("Bullet", _target);
		}
	}

	private void OnLoopBegin()
	{
		_looping = true;
		_loopTimer = loopDuration;
	}

	private void ShootBullet(string bullet, LogicEntity target)
	{
		if (target != null && !target.IsDead())
		{
			ILRuntimeAPI.Shoot(bullet, _actor, 0, _actor.tsTransform.Position, bulletHeight, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
		}
		else
		{
			ILRuntimeAPI.ShootByDirection(bullet, _actor, bulletRange, _actor.tsTransform.Forward, _actor.tsTransform.Position, bulletHeight);
		}
	}
}
