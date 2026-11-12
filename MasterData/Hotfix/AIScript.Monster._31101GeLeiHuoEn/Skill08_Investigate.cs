using System.Collections;
using TrueSync;

namespace AIScript.Monster._31101GeLeiHuoEn;

public class Skill08_Investigate : SkillSimpleBase
{
	private readonly string combo_key1 = "DogHunting";

	private TSVector2 SkillPos;

	private readonly string combo_key2 = "Collaboration";

	private readonly string combo_key3 = "RushAttack";

	private CoroutineNode DistanceCor;

	private bool _isChecking = true;

	private FP RushDistance;

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

	private CoroutineNode Sum;

	private int SkillTimes01;

	private LogicEntity Targetenemy;

	protected override void OnSkillEnable()
	{
		OutsideDiameter = OutsideDiameter_Common;
		InsideDiameter = InsideDiameter_Common;
		CentralSectorAngle = CentralSectorAngle_Common;
		SideSectorAngle = SideSectorAngle_Common;
		SectorAngle = SectorAngle_Common;
		GetNextPoint();
		SkillTimes01 = 0;
		SkillPos = GetPlaceHolderPosition("CenterPoint");
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
		StopCor(AimCor);
		StopCor(Sum);
		StopMove();
		CancelAim();
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 1.2, 72000);
		yield return WaitTime(0.1);
		BeginAttack(1, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.8);
		StartCor(ref Sum, SummonDog());
		CancelAttack();
		yield return WaitTime(0.1);
		StartCor(ref AimCor, KeepAiming());
		yield return WaitTime(1.8);
		if (SkillTimes01 == 1)
		{
			yield return WaitTime(10);
		}
		GetNextPoint();
		MoveToPosition(NextPosition, 0.1, AdventureActor.MovementMode.Walk);
		yield return WaitTime(2.5);
		if (SkillTimes01 == 1)
		{
			yield return WaitTime(7);
		}
		InterruptSkill();
	}

	protected IEnumerator SummonDog()
	{
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		TSVector2 normalized = (SkillPos - entityPosition).normalized;
		TSVector2 tSVector = new TSVector2(-normalized.y, normalized.x);
		TSVector2 spawnPosition = SkillPos + tSVector * -7 + normalized * 5.5;
		TSVector2 spawnPosition2 = SkillPos + tSVector * 7 + normalized * 5.5;
		TSVector2 spawnPosition3 = SkillPos + tSVector * 0 + normalized * 5.5;
		SummonTeammate(1, spawnPosition, -normalized);
		SummonTeammate(1, spawnPosition2, -normalized);
		SummonTeammate(1, spawnPosition3, -normalized);
		if (GetBuffNum(_actor, 311010010) >= 1)
		{
			yield return WaitTime(3);
			TSVector2 entityPosition2 = GetEntityPosition(GetCurrentPlayer());
			TSVector2 normalized2 = (SkillPos - entityPosition2).normalized;
			TSVector2 tSVector2 = new TSVector2(-normalized2.y, normalized2.x);
			_ = SkillPos + tSVector2 * -7 + normalized2 * 5.5;
			_ = SkillPos + tSVector2 * 7 + normalized2 * 5.5;
			_ = SkillPos + tSVector2 * 0 + normalized2 * 5.5;
		}
	}

	private void OnCustomEvt(IEvent evt)
	{
		SkillTimes01 = 1;
		StopCor(AimCor);
		StopMove();
		CancelAim();
		StartCor(Collaboration());
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
	}

	protected IEnumerator Collaboration()
	{
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		TSVector2 position = GetPosition();
		RushDistance = Distance(position, entityPosition);
		BeginAttack(2, combo_key2, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		_isChecking = true;
		BeginLookAt_NotWait(Targetenemy, 0.1, 7200);
		yield return WaitTime(0.36);
		Dash();
		DistanceCor = StartCor(StartCheckLoop());
		yield return WaitDashFinish();
		StopCor(DistanceCor);
		_isChecking = false;
		BeginAttack(3, combo_key3, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		InterruptSkill();
	}

	private void Dash()
	{
		BeginDashActorForward(1, 50, RushDistance, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	protected IEnumerator StartCheckLoop()
	{
		while (_isChecking)
		{
			yield return null;
			TSVector2 position = GetPosition();
			TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
			if (Distance(position, entityPosition) <= 1.6)
			{
				StopDash();
				_isChecking = false;
			}
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
