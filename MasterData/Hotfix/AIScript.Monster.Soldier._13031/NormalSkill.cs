using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._13031;

public class NormalSkill : SkillAdvancedBase
{
	private const string actionKey = "Attack";

	private const string fireEvent = "Fire";

	private const string bulletPath = "Bullet_Attack_1";

	private static readonly TSVector2 bulletFireOffset = new TSVector2(0.2, 0.35);

	private static readonly FP bulletHeight = 1.77;

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
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Attack", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("Fire"))
		{
			ShootBullet();
		}
	}

	private void ShootBullet()
	{
		TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(bulletFireOffset);
		if (_actor.attackTarget != null && !_actor.attackTarget.IsDead())
		{
			AdventureActor actor = _actor;
			FP range = 0;
			FP positionY = bulletHeight;
			LogicEntity attackTarget = _actor.attackTarget;
			ILRuntimeAPI.Shoot("Bullet_Attack_1", actor, range, position, positionY, default, attackTarget, AimType.Target, BulletDirectionType.BulletToTarget);
		}
		else
		{
			ILRuntimeAPI.ShootByDirection("Bullet_Attack_1", _actor, bulletRange, _actor.tsTransform.Forward, position, bulletHeight);
		}
	}
}
