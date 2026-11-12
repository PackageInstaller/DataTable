using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._119;

public class NormalSkill : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey[] comboTag = new ComboInputBuffer.ActionKey[3];

	private const string eventName_FanShoot = "119_Soldier_FanFire";

	private const string bulletKey_Fan = "Bullet_Soldier_119_Atk_N";

	private const int fanBulletCount = 3;

	private static readonly FP fanAngle = 33;

	private static readonly FP fanInnerRadius = 0.5;

	private static readonly FP shootPositionY = 1.5;

	private static readonly FP shootDirEpsilonSqr = (FP)1 / (FP)100;

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			LogicEntity logicEntity = ((SoldierActor)_actor).FindNearestConfrontTarget();
			if (logicEntity != null)
			{
				_actor.attackTarget = logicEntity;
			}
		}
		ComboInputBuffer.ActionKey[] keys = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "119_Soldier_FanFire") && !(_actor.buffComponent == null) && _actor.buffComponent.CheckBuffByBuffID(MainSkill.buffId_Trigger))
		{
			FanShoot();
		}
	}

	private void FanShoot()
	{
		TSVector2 multiShootDirection = _actor.tsTransform.Forward;
		LogicEntity attackTarget = _actor.attackTarget;
		if (attackTarget != null && !attackTarget.IsDead())
		{
			TSVector2 tSVector = attackTarget.tsTransform.Position - _actor.tsTransform.Position;
			if (tSVector.LengthSquared() > shootDirEpsilonSqr)
			{
				multiShootDirection = tSVector.normalized;
			}
		}
		ILRuntimeAPI.FanMultipleShoot(_actor, "Bullet_Soldier_119_Atk_N", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 3, 0, _actor.tsTransform.Position, shootPositionY, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, fanAngle, 0, fanInnerRadius);
	}
}
