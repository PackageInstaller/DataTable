using System.Collections;
using TrueSync;

namespace AIScript.Monster._17031ZhongNuJingYingQiShi;

public class Skill_CommonWander_Far : SkillSimpleBase
{
	private static readonly FP OutsideDiameter_Common = 12;

	private static readonly FP InsideDiameter_Common = 7;

	private static readonly FP CentralSectorAngle_Common = 10;

	private static readonly FP SideSectorAngle_Common = 10;

	private static readonly FP CentralSectorAngle_Near = 20;

	private static readonly FP SideSectorAngle_Near = 30;

	private static readonly FP SectorAngle_Common = 40;

	private static readonly FP SectorAngle_Near = 150;

	private DeterministicShape CentralAnnularSector;

	private DeterministicShape ClockwiseAnnularSector;

	private DeterministicShape AnticlockwiseAnnularSector;

	private DeterministicShape BackupAnnularSector;

	private DeterministicShape ChosenAnnularSector;

	private TSVector2 SectorDirection;

	private FP CentralSectorRotation;

	private FP ClockwiseSectorRotation;

	private FP AnticlockwiseSectorRotation;

	private FP OutsideDiameter;

	private FP InsideDiameter;

	private FP CentralSectorAngle;

	private FP SideSectorAngle;

	private FP SectorAngle;

	private TSVector2 TargetPosition;

	private TSVector2 NextPosition;

	private string WanderMode;

	private string LastWanderArea;

	private CoroutineNode AimCor;

	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakSkill", value: true);
		GetNextPoint();
		OutsideDiameter = OutsideDiameter_Common;
		InsideDiameter = InsideDiameter_Common;
		CentralSectorAngle = CentralSectorAngle_Common;
		SideSectorAngle = SideSectorAngle_Common;
		SectorAngle = SectorAngle_Common;
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakSkill", value: false);
		StopCor(AimCor);
		StopMove();
		CancelAim();
	}

	protected override IEnumerator DoMainLogic()
	{
		StartCor(ref AimCor, KeepAiming());
		while (true)
		{
			MoveToPosition(NextPosition, 0.1, AdventureActor.MovementMode.Walk);
			yield return WaitMoveStatus();
			yield return WaitTime(GetRandomValue(3, 4));
			GetNextPoint();
		}
	}

	private void GetNextPoint()
	{
		TargetPosition = GetEntityPositionObsoleted(GetAttackTarget(isUpToDate: true));
		SectorDirection = GetPosition() - TargetPosition;
		if (Distance(GetPosition(), TargetPosition) > OutsideDiameter_Common)
		{
			WanderMode = "ComeCloser";
		}
		else if (Distance(GetPosition(), TargetPosition) < InsideDiameter_Common)
		{
			WanderMode = "StayAway";
			if (GetRandomValue(0, 1) < 0.7)
			{
				OutsideDiameter = Distance(GetPosition(), TargetPosition) + 2;
				InsideDiameter = Distance(GetPosition(), TargetPosition) + 1;
				CentralSectorAngle = CentralSectorAngle_Near;
				SideSectorAngle = SideSectorAngle_Near;
				SectorAngle = SectorAngle_Near;
			}
		}
		else
		{
			WanderMode = "KeepDistance";
		}
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
		if (TargetPosition != GetShapeRandomPoint(ClockwiseAnnularSector, _actor, isReachable: true))
		{
			return ClockwiseAnnularSector;
		}
		return BackupAnnularSector;
	}

	private IEnumerator KeepAiming()
	{
		LogicEntity Target = GetAttackTarget();
		AimAtTarget(Target, 50);
		while (true)
		{
			if (!CheckTargetIsValid(Target))
			{
				InterruptSkill();
			}
			if (CalcAngleBetweenSelfAndAttackTarget() > 45)
			{
				CancelAim();
				yield return BeginLookAt(Target, 0, 300);
				AimAtTarget(Target, 50);
			}
			yield return null;
		}
	}
}
