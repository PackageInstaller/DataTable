using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu.HorrorGhost;

public class Skill_Wander : SkillSimpleBase
{
	private static readonly FP OutsideDiameter = 9;

	private static readonly FP InsideDiameter = 5;

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

	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakSkill", value: true);
		GetNextPoint();
	}

	protected override void OnSkillDisable()
	{
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
			yield return WaitTime(GetRandomValue(1, 4));
			GetNextPoint();
		}
	}

	private void GetNextPoint()
	{
		if (GetAttackTarget(isUpToDate: true) == null)
		{
			NextPosition = GetPosition();
			return;
		}
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
			if (NextPosition == TargetPosition)
			{
				NextPosition = GetPosition();
			}
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
