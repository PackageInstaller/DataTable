using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._13011;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "Support";

	private const string fireEvent = "Fire";

	private const string bulletPath = "Bullet_Support_1";

	private const string bulletPath_2 = "Bullet_Support_2";

	private const string bulletPath_3 = "Bullet_Support_3";

	private static readonly TSVector2 bulletFireOffset = new TSVector2(0, 1);

	private static readonly FP bulletHeight = 1.5;

	private static readonly FP bulletRange = 10;

	private int _potentialLv = 1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Support", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
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

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("Fire"))
		{
			ShootBullet();
		}
	}

	private void ShootBullet()
	{
		string text;
		if (_potentialLv >= 3)
		{
			text = "Bullet_Support_3";
		}
		else
		{
			text = ((_potentialLv >= 2) ? "Bullet_Support_2" : "Bullet_Support_1");
		}
		TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(bulletFireOffset);
		if (_actor.attackTarget != null && !_actor.attackTarget.IsDead())
		{
			string bulletAlias = text;
			AdventureActor actor = _actor;
			FP range = 0;
			FP positionY = bulletHeight;
			LogicEntity attackTarget = _actor.attackTarget;
			ILRuntimeAPI.Shoot(bulletAlias, actor, range, position, positionY, default, attackTarget, AimType.Target, BulletDirectionType.BulletToTarget);
		}
		else
		{
			ILRuntimeAPI.ShootByDirection(text, _actor, bulletRange, _actor.tsTransform.Forward, position, bulletHeight);
		}
	}
}
