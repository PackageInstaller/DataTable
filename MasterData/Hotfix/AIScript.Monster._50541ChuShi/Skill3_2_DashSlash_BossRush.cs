using System.Collections;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Skill3_2_DashSlash_BossRush : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] DashSlash = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly ComboInputBuffer.ActionKey[] DashSlashEnd1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly ComboInputBuffer.ActionKey[] DashSlashEnd2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.C,
		ComboInputBuffer.ActionKey.C
	};

	private static readonly FP DashSpeed = 5.25;

	private static readonly int SlashTimes = 6;

	private static readonly TSVector2 ShootPositionLeft = new TSVector2(-1, 1.3);

	private static readonly FP ShootPositionYLeft = 1.8;

	private static readonly TSVector2 ShootPositionRight = new TSVector2(1, 1.3);

	private static readonly FP ShootPositionYRight = 1.8;

	private FP DashAngleLimit;

	private int DashSlashTimeCount;

	private FP RotateSpeed;

	private int BattleStage;

	private long DashLoopWeaponFXL;

	private long DashLoopWeaponFXR;

	protected override void OnSkillEnable()
	{
		RotateSpeed = GetRotSpdInSkill();
		DashSlashTimeCount = 0;
		BattleStage = (int)(long)GetLogicTagFpValue(_actor, "BattleStage");
		switch (BattleStage)
		{
		case 1:
			DashAngleLimit = RotateSpeed * 0.3;
			break;
		case 2:
			DashAngleLimit = RotateSpeed * 0.3;
			break;
		case 3:
			DashAngleLimit = RotateSpeed * 0.5;
			break;
		}
	}

	protected override void OnSkillDisable()
	{
		StopDash();
		StopEffect(DashLoopWeaponFXL);
		StopEffect(DashLoopWeaponFXR);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, DashSlash, flushInputedKeys: true);
		yield return WaitCustomEvent("DashStartWeaponFX");
		if (BattleStage == 1)
		{
			PlayEffect("DashStartWeaponFXL");
			PlayEffect("DashStartWeaponFXR");
		}
		else
		{
			PlayEffect("DashStartFireWeaponFXL");
			PlayEffect("DashStartFireWeaponFXR");
		}
		yield return WaitCustomEvent("DashStartFX");
		if (BattleStage == 1)
		{
			Skill3_2_DashSlash_BossRush skill3_2_DashSlash_BossRush = this;
			TSVector2 position = GetPosition();
			FP rotation = GetRotation();
			skill3_2_DashSlash_BossRush.PlayEffect("DashStart", 1f, default, position, rotation);
		}
		else
		{
			Skill3_2_DashSlash_BossRush skill3_2_DashSlash_BossRush2 = this;
			TSVector2 position = GetPosition();
			FP rotation = GetRotation();
			skill3_2_DashSlash_BossRush2.PlayEffect("DashStartFire", 1f, default, position, rotation);
		}
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		if (BattleStage == 1)
		{
			PlayEffect("DashLoop");
		}
		else
		{
			PlayEffect("DashLoopFire1");
			DashLoopWeaponFXL = PlayEffect("DashLoopFire2");
			DashLoopWeaponFXR = PlayEffect("DashLoopFire3");
		}
		BeginDashActorForward(1, DashSpeed, 999, DashAngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0);
		WaitLookAt_NoWait(GetAttackTarget(isUpToDate: true), 999, DashAngleLimit);
		while (DashSlashTimeCount < SlashTimes)
		{
			yield return null;
		}
		StopWaitLookAt();
		StopDash();
		StopEffect(DashLoopWeaponFXL);
		StopEffect(DashLoopWeaponFXR);
		if (BattleStage == 1 || BattleStage == 2)
		{
			BeginAttack(2, DashSlashEnd1);
		}
		else if (BattleStage == 3)
		{
			BeginAttack(2, DashSlashEnd2);
			yield return WaitCustomEvent("StartTurn3");
			BeginLookAt_NotWait(GetAttackTarget(), 999, RotateSpeed * 2);
			yield return WaitCustomEvent("StopTurn3");
			StopWaitLookAt();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		DashSlashTimeCount++;
		if (DashSlashTimeCount < SlashTimes)
		{
			if (BattleStage == 1)
			{
				PlayEffect("DashLoop");
			}
			else
			{
				PlayEffect("DashLoopFire1");
			}
		}
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (BattleStage < 2 || DashSlashTimeCount > 2)
		{
			return;
		}
		if (eventName == "ShootL")
		{
			TSVector2 position = GetPosition();
			TSVector2 forward = GetForward();
			TSVector2 shootPositionLeft = ShootPositionLeft;
			FP radius = 8;
			FP innerRadius = 6;
			FP angle = 140;
			FP tSVectToAngle = GetTSVectToAngle(forward, 90);
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, shootPositionLeft, default, default, radius, innerRadius, angle, tSVectToAngle);
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			TSVector2 position2 = shapeRandomPoint;
			tSVectToAngle = 1;
			angle = 0;
			DeterministicShape shapeData2 = GetShapeData(DeterministicShape.ShapeType.Circle, position2, default, default, tSVectToAngle, angle);
			if (GetTargetsFromShape(shapeData2, GetTargetByTeammateIndex(1)).Count + GetTargetsFromShape(shapeData2, GetTargetByTeammateIndex(2)).Count > 0)
			{
				shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			}
			CircleMultipleShoot("Knife_Parabola_Fire", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, TransLocalPosToWorldPos(position, forward, ShootPositionLeft), ShootPositionYLeft, forward, 0, AimType.Position, BulletDirectionType.BulletToTarget, 0, 0, shapeRandomPoint);
		}
		else if (eventName == "ShootR")
		{
			TSVector2 position3 = GetPosition();
			TSVector2 forward2 = GetForward();
			TSVector2 shootPositionRight = ShootPositionRight;
			FP angle = 8;
			FP tSVectToAngle = 6;
			FP innerRadius = 140;
			FP radius = GetTSVectToAngle(forward2, -90);
			DeterministicShape shapeData3 = GetShapeData(DeterministicShape.ShapeType.Fan, shootPositionRight, default, default, angle, tSVectToAngle, innerRadius, radius);
			TSVector2 shapeRandomPoint2 = GetShapeRandomPoint(shapeData3, _actor, isReachable: true);
			TSVector2 position4 = shapeRandomPoint2;
			radius = 1;
			innerRadius = 0;
			DeterministicShape shapeData4 = GetShapeData(DeterministicShape.ShapeType.Circle, position4, default, default, radius, innerRadius);
			if (GetTargetsFromShape(shapeData4, GetTargetByTeammateIndex(1)).Count + GetTargetsFromShape(shapeData4, GetTargetByTeammateIndex(2)).Count > 0)
			{
				shapeRandomPoint2 = GetShapeRandomPoint(shapeData3, _actor, isReachable: true);
			}
			CircleMultipleShoot("Fork_Parabola_Fire", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, TransLocalPosToWorldPos(position3, forward2, ShootPositionRight), ShootPositionYRight, forward2, 0, AimType.Position, BulletDirectionType.BulletToTarget, 0, 0, shapeRandomPoint2);
		}
	}
}
