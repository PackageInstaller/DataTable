using System.Collections;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa_MiniBoss;

public class Skill01_SandBullet : SkillSimpleBase
{
	private static readonly string Fire = "SandBullet";

	private static readonly string Bullet = "Bullet_SandBullet";

	private static readonly FP AlignShootDelayTime = 0;

	private static readonly FP DurationTime = 0;

	private static readonly FP FireHeight = 2;

	private static readonly FP FireRange = 25;

	private static readonly FP BulletPos = 0;

	private static readonly FP DashSpeed = 30;

	private static readonly FP DashDistance = 5;

	private static readonly FP FireDistance = 8;

	private LogicEntity Targetenemy;

	private int BulletNum;

	private FP FireAngle;

	private FP AimTime;

	private long DashFX;

	protected override void OnSkillEnable()
	{
		if (GetLogicTagStringValue(_actor, "SkillLv") == "SkillLv_1")
		{
			if (GetMonsterTagValue(_actor, 1) == "Hard")
			{
				BulletNum = 5;
				FireAngle = 30;
				AimTime = 1;
			}
			else
			{
				BulletNum = 3;
				FireAngle = 30;
				AimTime = 1.5;
			}
		}
		else if (GetLogicTagStringValue(_actor, "SkillLv") == "SkillLv_2")
		{
			if (GetMonsterTagValue(_actor, 1) == "Hard")
			{
				BulletNum = 7;
				FireAngle = 45;
				AimTime = 1;
			}
			else
			{
				BulletNum = 5;
				FireAngle = 45;
				AimTime = 1.5;
			}
		}
		else
		{
			BulletNum = 9;
			FireAngle = 60;
			AimTime = 1;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginAttack(1, Fire, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(Targetenemy, AimTime, 180);
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < FireDistance)
		{
			yield return WaitCustomEvent("Back");
			MoveBack();
			DashFX = PlayEffect("fx_m30391_base_Attack_4_knife_dash");
			yield return WaitDashFinish();
			StopEffect(DashFX);
		}
		yield return WaitTime(AimTime);
		CancelAttack();
		SandBulletFire();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	private void SandBulletFire()
	{
		FanMultipleShoot(Bullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, AlignShootDelayTime, BulletNum, DurationTime, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 3.2)), FireHeight, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, FireAngle, FireRange, BulletPos);
	}

	private void MoveBack()
	{
		BeginDash(1, GetPosition() - GetEntityPosition(Targetenemy), DashSpeed, DashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}
}
