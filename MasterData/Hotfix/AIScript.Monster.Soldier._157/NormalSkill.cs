using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._157;

public class NormalSkill : SkillAdvancedBase
{
	private const string actionKey = "NormalAttack";

	private const string fireEvent = "157pugong";

	private const string normalBulletKey = "Bullet_NrmAtk_Soldier";

	private static readonly TSVector2 normalBulletOffset = new TSVector2(-0.3, 1);

	private static readonly FP normalBulletHeight = 1.5;

	private const int huntMarkBuffId_P3 = 250104902;

	private const string extraBulletKey = "Bullet_NrmAtk_DiaoShe_Soldier";

	private static readonly TSVector2 extraBulletOffset = new TSVector2(0, 1.5);

	private static readonly FP extraBulletHeight = 1.5;

	private static readonly FP extraBulletRange = 10;

	private bool _hitHuntMarkP3;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
		_hitHuntMarkP3 = false;
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	private void DoMainLogic()
	{
		_hitHuntMarkP3 = false;
		if (_actor.attackTarget != null && !_actor.attackTarget.IsDead())
		{
			_actor.AimAtTarget(_actor.attackTarget);
			_hitHuntMarkP3 = HasBuff(_actor.attackTarget, 250104902);
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("NormalAttack", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "157pugong"))
		{
			ShootNormalBullet();
			if (_hitHuntMarkP3)
			{
				ShootExtraBullet();
			}
		}
	}

	private void ShootNormalBullet()
	{
		TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * normalBulletOffset.x + _actor.tsTransform.Forward * normalBulletOffset.y;
		ILRuntimeAPI.ShootByDirection("Bullet_NrmAtk_Soldier", _actor, default, _actor.tsTransform.Forward, position, normalBulletHeight);
	}

	private static bool HasBuff(LogicEntity target, int buffId)
	{
		if (!(target is AdventureActor adventureActor) || adventureActor.buffComponent == null)
		{
			return false;
		}
		return adventureActor.buffComponent.CheckBuffByBuffID(buffId);
	}

	private void ShootExtraBullet()
	{
		TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(extraBulletOffset);
		if (_actor.attackTarget != null && !_actor.attackTarget.IsDead())
		{
			AdventureActor actor = _actor;
			FP range = 0;
			FP positionY = extraBulletHeight;
			LogicEntity attackTarget = _actor.attackTarget;
			ILRuntimeAPI.Shoot("Bullet_NrmAtk_DiaoShe_Soldier", actor, range, position, positionY, default, attackTarget, AimType.Target, BulletDirectionType.BulletToTarget);
		}
		else
		{
			ILRuntimeAPI.ShootByDirection("Bullet_NrmAtk_DiaoShe_Soldier", _actor, extraBulletRange, _actor.tsTransform.Forward, position, extraBulletHeight);
		}
	}
}
