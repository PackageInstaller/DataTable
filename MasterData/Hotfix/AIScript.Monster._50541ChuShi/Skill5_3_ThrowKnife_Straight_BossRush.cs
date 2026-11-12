using System.Collections;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Skill5_3_ThrowKnife_Straight_BossRush : SimpleAPI_ChuShi
{
	private static readonly ComboInputBuffer.ActionKey[] Throw = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	private static readonly int ShootTimes_Stage2 = 4;

	private static readonly int ShootTimes_Stage3 = 6;

	private FP BasicReflectDistance = 4.5;

	private FP incrementReflectDistance = 1.2;

	private int ShootTimes;

	private TSVector2 CenterPoint;

	private FP TurnSpeed;

	private int ShootCount;

	private TSVector2 PalabolaBulletStartPosition;

	private TSVector2 PalabolaBulletAimPosition;

	private FP PalabolaBulletStartPositionY;

	private TSVector2 PalabolaBulletDirection;

	private FP PalabolaBulletRotation;

	private string PalabolaBulletType;

	private FP PalabolaBulletDistance;

	private int BattleStage;

	private int PalabolaBulletShootCount;

	protected override void OnSkillEnable()
	{
		TurnSpeed = GetRotSpdInSkill();
		ShootCount = 0;
		PalabolaBulletShootCount = 0;
		BattleStage = (int)(long)GetLogicTagFpValue(_actor, "BattleStage");
		switch (BattleStage)
		{
		case 2:
			ShootTimes = ShootTimes_Stage2;
			break;
		case 3:
			ShootTimes = ShootTimes_Stage3;
			break;
		}
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 TargetPosition = GetEntityPositionObsoleted(GetAttackTarget());
		TSVector2 position = GetPosition();
		TSVector2 tSVector = TransLocalPosToWorldPos(TargetPosition, RotateTo(TSVector2.up, -40), TSVector2.up * 12);
		TSVector2 tSVector2 = TransLocalPosToWorldPos(TargetPosition, RotateTo(TSVector2.up, 130), TSVector2.up * 12);
		Skill5_3_ThrowKnife_Straight_BossRush skill5_3_ThrowKnife_Straight_BossRush = this;
		FP radius = 30;
		FP innerRadius = 0;
		FP angle = 220;
		FP rotation = 40;
		DeterministicShape shapeData = skill5_3_ThrowKnife_Straight_BossRush.GetShapeData(DeterministicShape.ShapeType.Fan, TargetPosition, default, default, radius, innerRadius, angle, rotation);
		if (GetTargetsFromShape(shapeData, GetTargetByDataID(_actor.dataID), includeSelf: true).Count == 0)
		{
			TSVector2 position2 = ((!(Distance(position, tSVector) > Distance(position, tSVector2))) ? tSVector : tSVector2);
			yield return StartCor(JumpToPoints(position2));
			if (!CheckTargetIsValid(GetAttackTarget()))
			{
				yield return BeginLookAtByPos(TargetPosition, 0, TurnSpeed);
			}
			else
			{
				yield return BeginLookAt(GetAttackTarget(), 0, TurnSpeed * 2);
			}
		}
		BeginAttack(1, Throw, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetAttackTarget(isUpToDate: true), 999, TurnSpeed);
		yield return WaitCustomEvent("StopTurn");
		StopWaitLookAt();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		if (BattleStage == 3)
		{
			if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 0)
			{
				BeginRotateAngle_NotWait(135, 52.5);
			}
			else
			{
				BeginRotateAngle_NotWait(-135, 52.5);
			}
		}
		while (ShootCount < ShootTimes)
		{
			yield return null;
		}
		CancelAttack();
		StopWaitLookAt();
		while (PalabolaBulletShootCount < ShootTimes * 2)
		{
			yield return null;
		}
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void OnBulletFinish(IEvent e)
	{
		if (!(e is AdventureBulletFinishEvent adventureBulletFinishEvent) || adventureBulletFinishEvent.owner != _actor || (!(adventureBulletFinishEvent.tag == "Knife_Straight_Fire") && !(adventureBulletFinishEvent.tag == "Fork_Straight_Fire")))
		{
			return;
		}
		PalabolaBulletStartPosition = adventureBulletFinishEvent.bulletPosition;
		PalabolaBulletStartPositionY = adventureBulletFinishEvent.bulletPositionY;
		PalabolaBulletDirection = CenterPoint - PalabolaBulletStartPosition;
		PalabolaBulletRotation = GetTSVectToAngle(PalabolaBulletDirection, 0);
		if (BattleStage == 2)
		{
			switch (PalabolaBulletShootCount)
			{
			case 0:
				PalabolaBulletRotation -= (FP)67.5;
				PalabolaBulletDistance = BasicReflectDistance;
				break;
			case 1:
				PalabolaBulletRotation -= (FP)22.5;
				PalabolaBulletDistance = BasicReflectDistance + incrementReflectDistance * 1;
				break;
			case 2:
				PalabolaBulletRotation += (FP)22.5;
				PalabolaBulletDistance = BasicReflectDistance + incrementReflectDistance * 2;
				break;
			case 3:
				PalabolaBulletRotation += (FP)67.5;
				PalabolaBulletDistance = BasicReflectDistance + incrementReflectDistance * 3;
				break;
			case 4:
				PalabolaBulletRotation -= (FP)67.5;
				PalabolaBulletDistance = BasicReflectDistance + incrementReflectDistance * 4;
				break;
			case 5:
				PalabolaBulletRotation -= (FP)22.5;
				PalabolaBulletDistance = BasicReflectDistance + incrementReflectDistance * 5;
				break;
			case 6:
				PalabolaBulletRotation += (FP)22.5;
				PalabolaBulletDistance = BasicReflectDistance + incrementReflectDistance * 6;
				break;
			case 7:
				PalabolaBulletRotation += (FP)67.5;
				PalabolaBulletDistance = BasicReflectDistance + incrementReflectDistance * 7;
				break;
			}
		}
		else
		{
			BasicReflectDistance = 2;
			incrementReflectDistance = 0.5;
			PalabolaBulletDistance = BasicReflectDistance + incrementReflectDistance * PalabolaBulletShootCount;
		}
		PalabolaBulletDirection = CenterPoint - PalabolaBulletStartPosition;
		TSVector2 palabolaBulletStartPosition = PalabolaBulletStartPosition;
		FP palabolaBulletDistance = PalabolaBulletDistance;
		FP innerRadius = PalabolaBulletDistance - 1;
		FP angle = 35;
		FP palabolaBulletRotation = PalabolaBulletRotation;
		PalabolaBulletAimPosition = GetShapeRandomPoint(GetShapeData(DeterministicShape.ShapeType.Fan, palabolaBulletStartPosition, default, default, palabolaBulletDistance, innerRadius, angle, palabolaBulletRotation), _actor, isReachable: true);
		string tag = adventureBulletFinishEvent.tag;
		if (!(tag == "Knife_Straight_Fire"))
		{
			if (tag == "Fork_Straight_Fire")
			{
				PalabolaBulletType = "Fork_Parabola_Fire";
			}
		}
		else
		{
			PalabolaBulletType = "Knife_Parabola_Fire";
		}
		FanMultipleShoot(PalabolaBulletType, AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 1, 0, PalabolaBulletStartPosition, PalabolaBulletStartPositionY, PalabolaBulletDirection, 0, AimType.Position, BulletDirectionType.BulletToTarget, 0, 0, 0, PalabolaBulletAimPosition);
		PalabolaBulletShootCount++;
	}

	protected override void OnComboLoop(int comboIndex)
	{
		ShootCount++;
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "ShootL" || eventName == "ShootR")
		{
			TSVector2 position = GetPosition();
			FP shootPositionY = 1.4;
			TSVector2 relativePoint = new TSVector2(-0.5, 1.91);
			TSVector2 relativePoint2 = new TSVector2(0.34, 1.92);
			TSVector2 shootPosition;
			string bulletAlias;
			if (eventName == "ShootL")
			{
				shootPosition = TransLocalPosToWorldPos(position, GetForward(), relativePoint);
				bulletAlias = "Knife_Straight_Fire";
			}
			else
			{
				shootPosition = TransLocalPosToWorldPos(position, GetForward(), relativePoint2);
				bulletAlias = "Fork_Straight_Fire";
			}
			FanMultipleShoot(bulletAlias, AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 1, 0, shootPosition, shootPositionY, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0, 0);
		}
	}
}
