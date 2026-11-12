using System.Collections;
using TrueSync;

namespace AIScript.Monster._31101GeLeiHuoEn;

public class Wander_Big : SkillSimpleBase
{
	private readonly string combo_key1 = "Collaboration";

	private readonly string combo_key2 = "RushAttack";

	private readonly string Dodge_Left = "Dodge_Left";

	private readonly string Dodge_Right = "Dodge_Right";

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

	private LogicEntity Targetenemy;

	private TSVector2 DodgePos;

	private CoroutineNode ActorMove;

	private CoroutineNode DodgeMove;

	private int SkillTimes01;

	protected override void OnSkillEnable()
	{
		_isChecking = true;
		SkillTimes01 = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
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
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
		StopCor(AimCor);
		StopMove();
		CancelAim();
		StopCor(ActorMove);
		StopCor(DodgeMove);
	}

	private void OnCustomEvt(IEvent evt)
	{
		SkillTimes01 = 1;
		StopCor(AimCor);
		StopCor(ActorMove);
		StopCor(DodgeMove);
		StopMove();
		CancelAim();
		StartCor(Collaboration());
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
	}

	protected override IEnumerator DoMainLogic()
	{
		ActorMove = StartCor(Move());
		yield return WaitTime(7);
		if (SkillTimes01 == 1)
		{
			yield return WaitTime(7);
		}
		InterruptSkill();
	}

	protected IEnumerator Move()
	{
		StartCor(ref AimCor, KeepAiming());
		MoveToPosition(NextPosition, 0.1, AdventureActor.MovementMode.Walk);
		yield return WaitTime(2.5);
		StopMove();
		GetNextPoint();
		DodgeMove = StartCor(Dodge());
		yield return WaitTime(0.5);
		StopCor(DodgeMove);
		MoveToPosition(NextPosition, 0.1, AdventureActor.MovementMode.Walk);
		yield return WaitTime(2.5);
		GetNextPoint();
		MoveToPosition(NextPosition, 0.1, AdventureActor.MovementMode.Walk);
	}

	protected IEnumerator Collaboration()
	{
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		TSVector2 position = GetPosition();
		RushDistance = Distance(position, entityPosition);
		BeginAttack(1, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		_isChecking = true;
		BeginLookAt_NotWait(Targetenemy, 0.1, 7200);
		yield return WaitTime(0.36);
		Dash();
		DistanceCor = StartCor(StartCheckLoop());
		yield return WaitDashFinish();
		StopCor(DistanceCor);
		_isChecking = false;
		BeginAttack(2, combo_key2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (GetBuffNum(_actor, 311010010) >= 1)
		{
			InterruptSkill();
			yield break;
		}
		GetNextPoint();
		StartCor(ref AimCor, KeepAiming());
		MoveToPosition(NextPosition, 0.1, AdventureActor.MovementMode.Walk);
		yield return WaitTime(3);
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

	private IEnumerator Dodge()
	{
		Wander_Big wander_Big = this;
		TSVector2 position = GetPosition();
		FP radius = 7;
		FP innerRadius = 6;
		DeterministicShape shapeData = wander_Big.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		DodgePos = shapeRandomPoint;
		TSVector2 position2 = GetPosition();
		TSVector2 forward = GetForward();
		TSVector2 value = DodgePos - position2;
		TSVector2 value2 = new TSVector2(forward.y, -forward.x);
		if (TSVector2.Dot(value, value2) < FP.Zero)
		{
			BeginAttack(3, Dodge_Left, flushInputedKeys: true, forceInterruptAttack: true);
		}
		else
		{
			BeginAttack(4, Dodge_Right, flushInputedKeys: true, forceInterruptAttack: true);
		}
		BeginLookAtByPos_NotWait(TargetPosition, 99, 9999);
		yield return WaitTime(0.25);
		BeginDash(9, DodgePos - GetPosition(), 100, Distance(DodgePos, GetPosition()), 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
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
