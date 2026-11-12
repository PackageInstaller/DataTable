using System.Collections;
using TrueSync;

namespace AIScript.Monster._Boss._Light._50251ShanDianLieQuan;

public class MiniBoss_Light_Skill02 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey._2
	};

	private readonly ComboInputBuffer.ActionKey[] Attack03 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey._3
	};

	private readonly ComboInputBuffer.ActionKey[] Move = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private TSVector2 FirePos;

	private string BulletName;

	protected override void OnSkillEnable()
	{
		if (GetBuffNum(_actor, 100129910) >= 1)
		{
			BulletName = "Bullet_50251_MiniBoss_Light_Skill02_2";
		}
		else
		{
			BulletName = "Bullet_50251_MiniBoss_Light_Skill02_1";
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity TargetPlayer = GetCurrentPlayer();
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -15 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 15)
		{
			BeginAttack(1, Attack01, flushInputedKeys: true);
			BeginLookAt_NotWait(TargetPlayer, 0.2, 120);
			yield return WaitFrame(45);
			BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
			BeginLookAt_NotWait(TargetPlayer, 0.37, 200);
			yield return WaitCustomEvent("Fire");
			yield return WaitFrame(3);
			StartCor(RandomShoot());
			StartCor(TraceShoot());
			yield return WaitTime(3);
			CancelAttack();
			yield return WaitCustomEvent("T1");
			BeginLookAt_NotWait(TargetPlayer, 1, 360);
			yield return WaitCustomEvent("T2");
			StopLookAt();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginAttack(1, Move, flushInputedKeys: true, forceInterruptAttack: true);
			BeginLookAt(TargetPlayer, 0.2, 150);
			BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
			BeginLookAt_NotWait(TargetPlayer, 0.2, 240);
			yield return WaitFrame(45);
			BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
			BeginLookAt_NotWait(TargetPlayer, 0.37, 200);
			yield return WaitCustomEvent("Fire");
			yield return WaitFrame(3);
			StartCor(RandomShoot());
			StartCor(TraceShoot());
			yield return WaitTime(3);
			CancelAttack();
			yield return WaitCustomEvent("T1");
			BeginLookAt_NotWait(TargetPlayer, 1, 360);
			yield return WaitCustomEvent("T2");
			StopLookAt();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	protected IEnumerator RandomShoot()
	{
		FirePos = GetPosition() + TSVector2.Rotate(new TSVector2(0, 2.1f), _actor.tsTransform.Rotation);
		int ShootTimes = 0;
		FP tSVectToAngle = GetTSVectToAngle(GetForward(), 0);
		MiniBoss_Light_Skill02 miniBoss_Light_Skill = this;
		TSVector2 position = GetPosition();
		FP radius = 10;
		FP innerRadius = 8;
		FP angle = 30;
		FP rotation = tSVectToAngle + 15;
		DeterministicShape Shape01 = miniBoss_Light_Skill.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		MiniBoss_Light_Skill02 miniBoss_Light_Skill2 = this;
		TSVector2 position2 = GetPosition();
		rotation = 10;
		angle = 8;
		innerRadius = 30;
		radius = tSVectToAngle - 15;
		DeterministicShape Shape2 = miniBoss_Light_Skill2.GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, rotation, angle, innerRadius, radius);
		FP FireRot = GetTSVectToAngle(GetForward(), 0);
		while (ShootTimes < 11)
		{
			PlayEffect("Atk02_BulletFire", 1f, 1.3, FirePos, FireRot, 0.5f, actorScale: true);
			CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, FirePos, 1.4, GetShapeRandomPoint(Shape01, _actor, isReachable: true) - FirePos, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
			yield return WaitTime(0.1);
			PlayEffect("Atk02_BulletFire", 1f, 1.3, FirePos, 90, 0.5f, actorScale: true);
			CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, FirePos, 1.4, GetShapeRandomPoint(Shape2, _actor, isReachable: true) - FirePos, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
			ShootTimes++;
			yield return WaitTime(0.1);
		}
	}

	protected IEnumerator TraceShoot()
	{
		int TraceTimes = 0;
		while (TraceTimes < 3)
		{
			if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -30 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 30)
			{
				CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, FirePos, 1.4, GetEntityPositionObsoleted(GetCurrentPlayer()) - FirePos, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
			}
			TraceTimes++;
			yield return WaitTime(0.75);
		}
	}
}
