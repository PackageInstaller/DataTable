using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_Shoot_Fire : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Shoot_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.P };

	private static readonly FP searchDistanc = 11;

	private static readonly List<FP> searchAngles = new List<FP>
	{
		50, 30, 10, -10, -30, -50, 70, -70, 90, -90,
		0
	};

	private static readonly int BulletAmount = 3;

	private static readonly FP WaitShootTime = 1.25;

	private TSVector2 ShootPosition;

	private TSVector2 ShootTargetPosition;

	private int BulletCount;

	private static readonly TSVector2 ShootPositionOffset = new TSVector2(0.3, 2.8);

	protected override IEnumerator DoMainLogic()
	{
		BulletCount = 0;
		BeginAttack(1, Start_Combo, flushInputedKeys: true);
		yield return WaitCustomEvent("ExitBattle");
		SetUnparalleledEnable();
		SetHideModelEnable();
		yield return WaitTime(0.5);
		GetAttackTarget(isUpToDate: true);
		TSVector2 pointsByActorAndScreenTopDirWithRotationAnglesAndDistance = ILRuntimeAPI.GetPointsByActorAndScreenTopDirWithRotationAnglesAndDistance(_actor, searchAngles, searchDistanc, searchDistanc);
		Teleport(pointsByActorAndScreenTopDirWithRotationAnglesAndDistance);
		BeginAttack(2, Shoot_Combo, flushInputedKeys: true);
		BeginLookAt_NotWait(GetAttackTarget(), 0.1, 1800);
		yield return WaitCustomEvent("JoinBattle");
		SetUnparalleledDisable();
		SetHideModelDisable();
		yield return WaitTime(WaitShootTime);
		ShootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), ShootPositionOffset);
		while (BulletCount < BulletAmount)
		{
			LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
			Skill_Shoot_Fire skill_Shoot_Fire = this;
			TSVector2 shootPosition = ShootPosition;
			FP radius = 15;
			FP innerRadius = 4;
			FP angle = 90;
			FP rotation = GetRotation();
			DeterministicShape shapeData = skill_Shoot_Fire.GetShapeData(DeterministicShape.ShapeType.Fan, shootPosition, default, default, radius, innerRadius, angle, rotation);
			Skill_Shoot_Fire skill_Shoot_Fire2 = this;
			TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(attackTarget);
			rotation = 3.5;
			angle = 0;
			DeterministicShape shapeData2 = skill_Shoot_Fire2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, rotation, angle);
			if (AreaCheckMonsterTarget(shapeData))
			{
				ShootTargetPosition = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
			}
			else
			{
				ShootTargetPosition = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			}
			FanMultipleShoot("Bullet", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 1, 0, ShootPosition, 1.7, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 1, 0, 0, ShootTargetPosition);
			BulletCount++;
			yield return WaitTime(0.15);
		}
		yield return WaitTime(0.5);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.5);
	}
}
