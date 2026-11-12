using System.Collections;
using TrueSync;

namespace AIScript.Monster._31101GeLeiHuoEn;

public class Wander_Small : SkillSimpleBase
{
	private readonly string combo_key3 = "Dodge_Jump_Back";

	private static readonly FP OutsideDiameter_Common = 3;

	private static readonly FP InsideDiameter_Common = 2;

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

	private LogicEntity Targetenemy;

	private FP SkillTimes02;

	protected override void OnSkillEnable()
	{
		SkillTimes02 = GetRandomValue(0, 1.5, isInt: true);
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakSkill", value: true);
		OutsideDiameter = OutsideDiameter_Common;
		InsideDiameter = InsideDiameter_Common;
		CentralSectorAngle = CentralSectorAngle_Common;
		SideSectorAngle = SideSectorAngle_Common;
		SectorAngle = SectorAngle_Common;
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
		if (SkillTimes02 == 1)
		{
			LogicEntity currentPlayer = GetCurrentPlayer();
			if (Distance(GetPosition(), GetEntityPosition(currentPlayer)) <= 4)
			{
				GetEnemy();
				BeginLookAt_NotWait(Targetenemy, 0.1, 72000);
				yield return WaitTime(0.1);
				BeginAttack(1, combo_key3, flushInputedKeys: true, forceInterruptAttack: true);
				Dash1();
				yield return WaitTime(1.33);
			}
		}
		StartCor(ref AimCor, KeepAiming());
		MoveToPosition(NextPosition, 0.1, AdventureActor.MovementMode.Walk);
		if (GetBuffNum(_actor, 311010010) >= 1)
		{
			yield return WaitTime(1);
			InterruptSkill();
		}
		else
		{
			yield return WaitTime(2.5);
			InterruptSkill();
		}
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	private void Dash1()
	{
		BeginDash(2, -GetForward(), 8, 7, 30, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.3);
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
			return AnticlockwiseAnnularSector;
		}
		return ClockwiseAnnularSector;
	}

	private IEnumerator KeepAiming()
	{
		LogicEntity Target = GetAttackTarget();
		AimAtTarget(Target, 50);
		while (CheckTargetIsValid(Target))
		{
			if (CalcAngleBetweenSelfAndAttackTarget() > 45)
			{
				CancelAim();
				yield return BeginLookAt(Target, 0, 300);
				AimAtTarget(Target, 50);
			}
			yield return null;
		}
		InterruptSkill();
	}
}
