using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._10003;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill";

	private const string fireEvent = "Fire";

	private const string bulletPath = "Bullet";

	private static readonly FP bulletHeight = 3.5;

	private static readonly FP bulletRange = 10;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
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
		_skill.Clear();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("Fire"))
		{
			ShootBullet("Bullet", _actor.attackTarget);
		}
	}

	private void ShootBullet(string bullet, LogicEntity target)
	{
		if (target != null && !target.IsDead())
		{
			TSVector2 position = _actor.tsTransform.Position;
			ILRuntimeAPI.Shoot(bullet, _actor, 0, position, bulletHeight, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
		}
		else
		{
			ILRuntimeAPI.ShootByDirection(bullet, _actor, bulletRange, _actor.tsTransform.Forward, _actor.tsTransform.Position, bulletHeight);
		}
	}
}
