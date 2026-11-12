using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._133;

public class SupportSkill : SkillAdvancedBase
{
	private string actionKey = "Support";

	private const string fireEvent = "Fire";

	private const string bulletPath1 = "SupportBullet";

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
	}

	private void DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals("Fire"))
		{
			ShootBullet("SupportBullet");
		}
	}

	private void ShootBullet(string bulletPath)
	{
		if (_actor.attackTarget != null && !_actor.attackTarget.IsDead())
		{
			TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(new TSVector2(0, 1.5f));
			AdventureActor actor = _actor;
			FP range = 0;
			FP positionY = 1.8;
			LogicEntity attackTarget = _actor.attackTarget;
			ILRuntimeAPI.Shoot(bulletPath, actor, range, position, positionY, default, attackTarget, AimType.Target, BulletDirectionType.BulletToTarget);
		}
		else
		{
			ILRuntimeAPI.ShootByDirection(bulletPath, _actor, default, _actor.tsTransform.Forward, _actor.tsTransform.Position);
		}
	}
}
