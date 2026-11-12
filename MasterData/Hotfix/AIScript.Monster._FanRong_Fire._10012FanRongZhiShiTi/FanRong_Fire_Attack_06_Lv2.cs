using System.Collections;
using TrueSync;

namespace AIScript.Monster._FanRong_Fire._10012FanRongZhiShiTi;

public class FanRong_Fire_Attack_06_Lv2 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1768846440,
		(ComboInputBuffer.ActionKey)1866622830,
		(ComboInputBuffer.ActionKey)1663988844
	};

	private readonly string Turn01 = "T1";

	private readonly string BulletShoot = "Shoot";

	private readonly string BulletName = "Weapon_FanRong_Fire_Skill06_Bullet_01";

	private TSVector2 LastPos;

	private FP Times01;

	private FP Times02;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, FireAttack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(90);
		CancelAttack();
		yield return WaitCustomEvent(BulletShoot);
		SetInitial();
		DoShoot01();
		yield return WaitTime(0.3);
		StartCor(AttackCombo());
		yield return WaitTime(0.3);
		StartCor(AttackCombo());
		yield return WaitCustomEvent(Turn01);
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.35, 120);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void SetInitial()
	{
		Times01 = 1;
		Times02 = 1;
		LastPos = GetEntityPositionObsoleted(GetCurrentPlayer());
	}

	private IEnumerator AttackCombo()
	{
		DoShoot02();
		yield return WaitFrame(3);
		DoShoot03();
	}

	protected void DoShoot01()
	{
		TSVector2 tSVector = GetPosition() + TSVector2.Rotate(new TSVector2(0, 2.5f), _actor.tsTransform.Rotation);
		FP radius = Distance(tSVector, GetEntityPositionObsoleted(GetCurrentPlayer()));
		TSVector2 multiShootDirection = RotateTo(GetForward(), CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true));
		CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, tSVector, 10, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, radius, 0);
	}

	protected void DoShoot02()
	{
		TSVector2 tSVector = GetPosition() + TSVector2.Rotate(new TSVector2(0, 2.5f), _actor.tsTransform.Rotation);
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		FP fP = Distance(tSVector, GetEntityPositionObsoleted(GetCurrentPlayer()));
		TSVector2 multiShootDirection = RotateTo(GetForward(), CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true));
		if (Distance(LastPos, entityPositionObsoleted) < 1)
		{
			if (Times01 == 1)
			{
				Times01 = 2;
				CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, tSVector, 10, multiShootDirection, -15, AimType.Default, BulletDirectionType.ActorToBullet, fP + 2, 0);
			}
			else
			{
				CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, tSVector, 10, multiShootDirection, 15, AimType.Default, BulletDirectionType.ActorToBullet, fP - 2, 0);
			}
		}
		else
		{
			LastPos = GetEntityPositionObsoleted(GetCurrentPlayer());
			CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, tSVector, 10, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, fP, 0);
		}
	}

	protected void DoShoot03()
	{
		TSVector2 tSVector = GetPosition() + TSVector2.Rotate(new TSVector2(0, 2.5f), _actor.tsTransform.Rotation);
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		FP fP = Distance(tSVector, GetEntityPositionObsoleted(GetCurrentPlayer()));
		TSVector2 multiShootDirection = RotateTo(GetForward(), CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true));
		if (Distance(LastPos, entityPositionObsoleted) < 1)
		{
			if (Times02 == 1)
			{
				Times02 = 2;
				CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, tSVector, 10, multiShootDirection, 15, AimType.Default, BulletDirectionType.ActorToBullet, fP + 2, 0);
			}
			else
			{
				CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, tSVector, 10, multiShootDirection, -15, AimType.Default, BulletDirectionType.ActorToBullet, fP - 2, 0);
			}
		}
		else
		{
			LastPos = GetEntityPositionObsoleted(GetCurrentPlayer());
			CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, tSVector, 10, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, fP, 0);
		}
	}
}
