using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Idle : SkillSimpleBase
{
	private static readonly string combo_Show = "Show";

	private static readonly string combo_Turn_Left = "Turn_Left";

	private static readonly string combo_Turn_Right = "Turn_Right";

	private static readonly FP OutsideDiameter = 3;

	private static readonly FP InsideDiameter = 2;

	private static readonly FP CentralSectorAngle = 20;

	private static readonly FP SideSectorAngle = 30;

	private static readonly FP SectorAngle = 100;

	private DeterministicShape CentralAnnularSector;

	private DeterministicShape ClockwiseAnnularSector;

	private DeterministicShape AnticlockwiseAnnularSector;

	private DeterministicShape BackupAnnularSector;

	private DeterministicShape ChosenAnnularSector;

	private TSVector2 SectorDirection;

	private FP CentralSectorRotation;

	private FP ClockwiseSectorRotation;

	private FP AnticlockwiseSectorRotation;

	private TSVector2 TargetPosition;

	private TSVector2 NextPosition;

	private string WanderMode;

	private string LastWanderArea;

	private CoroutineNode AimCor;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCor(AimCor);
		StopMove();
		CancelAim();
		SetLogicTagToggleValue(_actor, Config.Skill_Idle_Finish, value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -90 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 90)
		{
			StartCor(ref AimCor, KeepAiming());
			GetNextPoint();
			MoveToPosition(NextPosition, 0.1, AdventureActor.MovementMode.Walk);
			yield return WaitTime(1.5);
		}
		else if ((CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 90 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 180) || (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= -180 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < -90))
		{
			string actionKey = ((CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 0) ? combo_Turn_Left : combo_Turn_Right);
			BeginAttack(1, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
			LogicEntity logicEntity = GetAttackTarget();
			if (logicEntity == null)
			{
				logicEntity = GetCurrentPlayer();
			}
			TSVector2 entityPosition = GetEntityPosition(logicEntity);
			BeginLookAtByPos(entityPosition, 0.66, (FP)90 / (FP)0.66);
			yield return WaitTime(0.66);
			StopWaitLookAt();
			BeginAttack(1, combo_Show, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private void GetNextPoint()
	{
		TargetPosition = GetEntityPosition(GetAttackTarget(isUpToDate: true));
		SectorDirection = GetPosition() - TargetPosition;
		CentralSectorRotation = GetTSVectToAngle(SectorDirection, 0);
		ClockwiseSectorRotation = GetTSVectToAngle(SectorDirection, -(SectorAngle / 2 - SideSectorAngle / 2));
		AnticlockwiseSectorRotation = GetTSVectToAngle(SectorDirection, SectorAngle / 2 - SideSectorAngle / 2);
		TSVector2 targetPosition = TargetPosition;
		FP outsideDiameter = OutsideDiameter;
		FP insideDiameter = InsideDiameter;
		FP centralSectorAngle = CentralSectorAngle;
		FP centralSectorRotation = CentralSectorRotation;
		CentralAnnularSector = GetShapeData(DeterministicShape.ShapeType.Fan, targetPosition, default, default, outsideDiameter, insideDiameter, centralSectorAngle, centralSectorRotation);
		TSVector2 targetPosition2 = TargetPosition;
		centralSectorRotation = OutsideDiameter;
		centralSectorAngle = InsideDiameter;
		insideDiameter = SideSectorAngle;
		outsideDiameter = ClockwiseSectorRotation;
		ClockwiseAnnularSector = GetShapeData(DeterministicShape.ShapeType.Fan, targetPosition2, default, default, centralSectorRotation, centralSectorAngle, insideDiameter, outsideDiameter);
		TSVector2 targetPosition3 = TargetPosition;
		outsideDiameter = OutsideDiameter;
		insideDiameter = InsideDiameter;
		centralSectorAngle = SideSectorAngle;
		centralSectorRotation = AnticlockwiseSectorRotation;
		AnticlockwiseAnnularSector = GetShapeData(DeterministicShape.ShapeType.Fan, targetPosition3, default, default, outsideDiameter, insideDiameter, centralSectorAngle, centralSectorRotation);
		TSVector2 targetPosition4 = TargetPosition;
		centralSectorRotation = OutsideDiameter;
		centralSectorAngle = InsideDiameter;
		insideDiameter = 270;
		outsideDiameter = CentralSectorRotation;
		BackupAnnularSector = GetShapeData(DeterministicShape.ShapeType.Fan, targetPosition4, default, default, centralSectorRotation, centralSectorAngle, insideDiameter, outsideDiameter);
		if (Distance(GetPosition(), TargetPosition) > OutsideDiameter)
		{
			WanderMode = "ComeCloser";
		}
		else if (Distance(GetPosition(), TargetPosition) < InsideDiameter)
		{
			WanderMode = "StayAway";
		}
		else
		{
			WanderMode = "KeepDistance";
		}
		LastWanderArea = GetLogicTagStringValue(_actor, "LastWanderArea");
		if (WanderMode == "ComeCloser")
		{
			SetLogicTagStringValue(_actor, "LastWanderArea", "CentralSector");
			ChosenAnnularSector = CentralAnnularSector;
		}
		else if (WanderMode == "StayAway")
		{
			if (LastWanderArea == "CentralSector")
			{
				ChosenAnnularSector = GetRandomSector();
			}
			else
			{
				ChosenAnnularSector = CentralAnnularSector;
				SetLogicTagStringValue(_actor, "LastWanderArea", "CentralSector");
			}
		}
		else
		{
			ChosenAnnularSector = GetRandomSector();
		}
		NextPosition = GetShapeRandomPoint(ChosenAnnularSector, _actor, isReachable: true);
		if (NextPosition == TargetPosition)
		{
			ChosenAnnularSector = GetBackupSector();
			NextPosition = GetShapeRandomPoint(ChosenAnnularSector, _actor, isReachable: true);
		}
	}

	private DeterministicShape GetRandomSector()
	{
		if (LastWanderArea == "ClockwiseSector")
		{
			SetLogicTagStringValue(_actor, "LastWanderArea", "AnticlockwiseSector");
			return AnticlockwiseAnnularSector;
		}
		if (LastWanderArea == "AnticlockwiseSector")
		{
			SetLogicTagStringValue(_actor, "LastWanderArea", "ClockwiseSector");
			return ClockwiseAnnularSector;
		}
		if (GetRandomValue(0, 1) >= 0.5)
		{
			SetLogicTagStringValue(_actor, "LastWanderArea", "AnticlockwiseSector");
			return AnticlockwiseAnnularSector;
		}
		SetLogicTagStringValue(_actor, "LastWanderArea", "ClockwiseSector");
		return ClockwiseAnnularSector;
	}

	private DeterministicShape GetBackupSector()
	{
		LastWanderArea = GetLogicTagStringValue(_actor, "LastWanderArea");
		if (LastWanderArea == "CentralSector")
		{
			return BackupAnnularSector;
		}
		if (LastWanderArea == "ClockwiseSector")
		{
			if (TargetPosition != GetShapeRandomPoint(AnticlockwiseAnnularSector, _actor, isReachable: true))
			{
				return AnticlockwiseAnnularSector;
			}
			return BackupAnnularSector;
		}
		if (TargetPosition != GetShapeRandomPoint(AnticlockwiseAnnularSector, _actor, isReachable: true))
		{
			return AnticlockwiseAnnularSector;
		}
		return BackupAnnularSector;
	}

	private IEnumerator KeepAiming()
	{
		LogicEntity Target = GetAttackTarget();
		AimAtTarget(Target, 35);
		while (CheckTargetIsValid(Target))
		{
			if (CalcAngleBetweenSelfAndAttackTarget() > 45)
			{
				CancelAim();
				AimAtTarget(Target, 70);
			}
			yield return null;
		}
		InterruptSkill();
	}
}
