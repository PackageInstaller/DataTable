using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._132;

public class SupportSkill : SkillAdvancedBase
{
	private string actionKey = "Support";

	private const string fireEvent = "Fire";

	private const string bulletPath = "Bullet";

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
		string actionTag = actionKey;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("Fire"))
		{
			ShootBullet("Bullet");
		}
	}

	private void ShootBullet(string bullet)
	{
		if (_actor.attackTarget != null && !_actor.attackTarget.IsDead())
		{
			TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(new TSVector2(0, 1.5f));
			AdventureActor actor = _actor;
			FP range = 0;
			FP positionY = 1.8;
			LogicEntity attackTarget = _actor.attackTarget;
			ILRuntimeAPI.Shoot(bullet, actor, range, position, positionY, default, attackTarget, AimType.Target, BulletDirectionType.BulletToTarget);
		}
		else
		{
			ILRuntimeAPI.ShootByDirection(bullet, _actor, default, _actor.tsTransform.Forward, _actor.tsTransform.Position);
		}
	}
}
