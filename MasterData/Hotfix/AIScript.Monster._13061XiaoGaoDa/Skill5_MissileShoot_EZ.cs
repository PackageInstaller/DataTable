using System.Collections;
using TrueSync;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill5_MissileShoot_EZ : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.I };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_H = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private static readonly string missilebullet = "Weapon_XiaoGaoDa_Throw_EZ";

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAtByPos(new TSVector2(0, 0), 0, 400);
		yield return WaitTime(0.5);
		FP dis = Distance(GetEntityPositionObsoleted(_actor), new TSVector2(0, 0));
		if (dis < 3)
		{
			MoveToPosition(new TSVector2(0, 0), 0.1f);
			WaitMoveStatus();
		}
		else
		{
			BeginAttack(1, actionKeys_H, flushInputedKeys: true);
			yield return WaitTime(1.3);
			int num = 40;
			doDash(dis, num);
			yield return WaitDashFinish();
			CancelAttack();
		}
		yield return WaitTime(0.1);
		BeginLookAtByPos(new TSVector2(0, 99), 0, 700);
		BeginAttack(2, _actionKeys, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.2);
		FanMultipleShoot(missilebullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, _actor.tsTransform.Position, 1, GetEntityForward(_actor), 0, AimType.Position, BulletDirectionType.BulletToTarget, 30, 10, 0, new TSVector2(10, 0));
		FanMultipleShoot(missilebullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, _actor.tsTransform.Position, 1, GetEntityForward(_actor), 0, AimType.Position, BulletDirectionType.BulletToTarget, 30, 10, 0, new TSVector2(-10, 0));
		FanMultipleShoot(missilebullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, _actor.tsTransform.Position, 1, GetEntityForward(_actor), 0, AimType.Position, BulletDirectionType.BulletToTarget, 30, 10, 0, new TSVector2(0, 10));
		FanMultipleShoot(missilebullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, _actor.tsTransform.Position, 1, GetEntityForward(_actor), 0, AimType.Position, BulletDirectionType.BulletToTarget, 30, 10, 0, new TSVector2(0, -10));
		yield return WaitTime(2);
		FanMultipleShoot(missilebullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, _actor.tsTransform.Position, 1, GetEntityForward(_actor), 0, AimType.Position, BulletDirectionType.BulletToTarget, 30, 10, 0, new TSVector2(0, 6));
		FanMultipleShoot(missilebullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, _actor.tsTransform.Position, 1, GetEntityForward(_actor), 0, AimType.Position, BulletDirectionType.BulletToTarget, 30, 10, 0, new TSVector2(5.2, -3));
		FanMultipleShoot(missilebullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, _actor.tsTransform.Position, 1, GetEntityForward(_actor), 0, AimType.Position, BulletDirectionType.BulletToTarget, 30, 10, 0, new TSVector2(-5.2, -3));
		yield return WaitTime(2);
		FanMultipleShoot(missilebullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, _actor.tsTransform.Position, 1, GetEntityForward(_actor), 0, AimType.Position, BulletDirectionType.BulletToTarget, 30, 10, 0, new TSVector2(8, 8));
		FanMultipleShoot(missilebullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, _actor.tsTransform.Position, 1, GetEntityForward(_actor), 0, AimType.Position, BulletDirectionType.BulletToTarget, 30, 10, 0, new TSVector2(8, -8));
		FanMultipleShoot(missilebullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, _actor.tsTransform.Position, 1, GetEntityForward(_actor), 0, AimType.Position, BulletDirectionType.BulletToTarget, 30, 10, 0, new TSVector2(-8, 8));
		FanMultipleShoot(missilebullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, _actor.tsTransform.Position, 1, GetEntityForward(_actor), 0, AimType.Position, BulletDirectionType.BulletToTarget, 30, 10, 0, new TSVector2(-8, -8));
		yield return WaitTime(0.8);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void doDash(FP dis, FP dash_spd)
	{
		BeginDashActorForward(1, dash_spd, dis, 40, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
