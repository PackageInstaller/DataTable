using System.Collections;
using TrueSync;

namespace AIScript.Monster._50201WeiBing;

public class Skill_Dash : SkillSimpleBase
{
	private static readonly FP DashSpeed = 10;

	private static readonly FP BrakeSpeed = 7;

	private static readonly FP DashRotateSpeed = 30;

	private static readonly FP DashJumpSpeed = 10;

	private static readonly FP MaxDashDistance = 12;

	private static readonly FP ObstacleCheckDistanceHigh = 3;

	private static readonly FP ObstacleCheckDistanceLow = 1;

	private static readonly FP ObstacleCheckDistanceFirst = 2;

	private static readonly FP EnemyCheckDistance_Attack = 5.5;

	private static readonly FP EnemyCheckDistance_JumpAttack = 10;

	private static readonly FP EnemyCheckAngle = 120;

	private static readonly FP ObstacleCheckWidth = 0.8;

	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] End1_JumpAttack_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] End2_CrushStop_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] End3_Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly ComboInputBuffer.ActionKey[] End4_Throw_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly ComboInputBuffer.ActionKey[] Jump_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private LogicEntity AttackTarget;

	private FP SkillRotSpeed;

	private FP RemainDistance;

	private int EndType;

	private bool HasJumped;

	private CoroutineNode CheckDistanceCorNode;

	private DeterministicShape CheckObstacleShapeHigh;

	private DeterministicShape CheckObstacleShapeLow;

	private DeterministicShape CheckObstacleShapeFirst;

	private DeterministicShape CheckObstacleShapeNear;

	private DeterministicShape CheckEnemyShape_Attack;

	private DeterministicShape CheckEnemyShape_JumpAttack;

	private DeterministicShape CheckEnemyShape_Throw;

	private TSVector2 StartPosition;

	private TSVector2 JumpPosition;

	private bool SkillAnotherTime;

	private bool FirstDashEnd;

	protected override void OnSkillEnable()
	{
		SkillRotSpeed = GetRotSpdInSkill();
		SkillRotSpeed = 500;
		HasJumped = false;
		EndType = 3;
		RemainDistance = 0;
		StartPosition = GetPosition();
		SkillAnotherTime = false;
		FirstDashEnd = false;
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		Skill_Dash skill_Dash = this;
		Skill_Dash skill_Dash2 = this;
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), GetTSVector2(0, ObstacleCheckDistanceFirst / 2));
		FP obstacleCheckWidth = ObstacleCheckWidth;
		FP obstacleCheckDistanceFirst = ObstacleCheckDistanceFirst;
		FP rotation = GetRotation();
		skill_Dash.CheckObstacleShapeFirst = skill_Dash2.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, obstacleCheckWidth, obstacleCheckDistanceFirst, default, default, default, rotation);
		if (AreaCheckObstacle(CheckObstacleShapeFirst))
		{
			Skill_Dash skill_Dash3 = this;
			TSVector2 position2 = GetPosition();
			rotation = 5;
			FP innerRadius = 4;
			FP angle = 150;
			FP rotation2 = GetRotation() * -1;
			DeterministicShape shapeData = skill_Dash3.GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, rotation, innerRadius, angle, rotation2);
			MoveToPosition(GetShapeRandomPoint(shapeData, _actor, isReachable: true), 0.1);
			yield return WaitMoveStatus();
		}
		AttackTarget = GetAttackTarget(isUpToDate: true);
		BeginAttack(1, Start_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		WaitLookAt_NoWait(AttackTarget, 999, 500);
		yield return WaitCustomEvent("TurnEnd");
		StopWaitLookAt();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		WaitLookAt_NoWait(AttackTarget, 999, 30);
		BeginDashActorForward(1, DashSpeed, MaxDashDistance, DashRotateSpeed, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		StartCor(ref CheckDistanceCorNode, CheckDistance());
		while (!FirstDashEnd)
		{
			yield return null;
		}
		StopWaitLookAt();
		yield return StartCor(EndLogic());
		if (SkillAnotherTime)
		{
			StopWaitLookAt();
			yield return StartCor(EndLogic());
		}
	}

	private IEnumerator CheckDistance()
	{
		while (true)
		{
			Skill_Dash skill_Dash = this;
			Skill_Dash skill_Dash2 = this;
			TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), GetTSVector2(0, ObstacleCheckDistanceHigh / 2));
			FP obstacleCheckWidth = ObstacleCheckWidth;
			FP obstacleCheckDistanceHigh = ObstacleCheckDistanceHigh;
			FP rotation = GetRotation();
			skill_Dash.CheckObstacleShapeHigh = skill_Dash2.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, obstacleCheckWidth, obstacleCheckDistanceHigh, default, default, default, rotation);
			Skill_Dash skill_Dash3 = this;
			Skill_Dash skill_Dash4 = this;
			TSVector2 position2 = GetPosition();
			rotation = EnemyCheckDistance_Attack;
			FP innerRadius = 0;
			FP enemyCheckAngle = EnemyCheckAngle;
			FP rotation2 = GetRotation();
			skill_Dash3.CheckEnemyShape_Attack = skill_Dash4.GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, rotation, innerRadius, enemyCheckAngle, rotation2);
			Skill_Dash skill_Dash5 = this;
			Skill_Dash skill_Dash6 = this;
			TSVector2 position3 = GetPosition();
			rotation2 = EnemyCheckDistance_JumpAttack;
			enemyCheckAngle = 0;
			innerRadius = EnemyCheckAngle;
			rotation = GetRotation();
			skill_Dash5.CheckEnemyShape_JumpAttack = skill_Dash6.GetShapeData(DeterministicShape.ShapeType.Fan, position3, default, default, rotation2, enemyCheckAngle, innerRadius, rotation);
			Skill_Dash skill_Dash7 = this;
			Skill_Dash skill_Dash8 = this;
			TSVector2 position4 = GetPosition();
			rotation = 99;
			innerRadius = 0;
			enemyCheckAngle = EnemyCheckAngle;
			rotation2 = GetRotation();
			skill_Dash7.CheckEnemyShape_Throw = skill_Dash8.GetShapeData(DeterministicShape.ShapeType.Fan, position4, default, default, rotation, innerRadius, enemyCheckAngle, rotation2);
			Skill_Dash skill_Dash9 = this;
			Skill_Dash skill_Dash10 = this;
			TSVector2 position5 = GetPosition();
			rotation2 = ObstacleCheckDistanceLow;
			enemyCheckAngle = 0;
			innerRadius = 120;
			rotation = GetRotation();
			skill_Dash9.CheckObstacleShapeNear = skill_Dash10.GetShapeData(DeterministicShape.ShapeType.Fan, position5, default, default, rotation2, enemyCheckAngle, innerRadius, rotation);
			bool num = AreaCheckObstacle(CheckObstacleShapeHigh, checkHeight: true, HeightClass.High) || AreaCheckObstacle(CheckObstacleShapeHigh, checkHeight: true);
			bool flag = AreaCheckObstacle(CheckObstacleShapeNear);
			if (num)
			{
				EndType = 2;
				FirstDashEnd = true;
			}
			else if (AreaCheckMonsterTarget(CheckEnemyShape_Attack))
			{
				EndType = 3;
				FirstDashEnd = true;
			}
			else if (flag && !HasJumped && AreaCheckMonsterTarget(CheckEnemyShape_JumpAttack) && QueryPositionReachable(_actor, TransLocalPosToWorldPos(GetPosition(), GetForward(), GetTSVector2(0, DashSpeed * 0.45 + ObstacleCheckDistanceLow))))
			{
				EndType = 1;
				FirstDashEnd = true;
			}
			else if (flag && AreaCheckMonsterTarget(CheckEnemyShape_Throw))
			{
				bool flag2 = QueryPositionReachable(_actor, TransLocalPosToWorldPos(GetPosition(), GetForward(), GetTSVector2(0, 0.5 * DashJumpSpeed)));
				if (!HasJumped & flag2)
				{
					EndType = 5;
					HasJumped = true;
					FirstDashEnd = true;
					while (!SkillAnotherTime)
					{
						yield return null;
					}
					EndType = 3;
				}
				else if (flag)
				{
					yield return null;
				}
			}
			yield return null;
		}
	}

	private IEnumerator EndLogic()
	{
		switch (EndType)
		{
		case 2:
			StopDash();
			BeginAttack(22, End2_CrushStop_Combo);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			break;
		case 1:
			StopDash();
			BeginAttack(21, End1_JumpAttack_Combo);
			yield return WaitCustomEvent("Dash");
			JumpPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), GetTSVector2(0, DashJumpSpeed * 0.45 + ObstacleCheckDistanceLow));
			if (Distance(GetPosition(), JumpPosition) >= Distance(GetPosition(), GetEntityPositionObsoleted(AttackTarget)) && CheckTargetIsValid(AttackTarget))
			{
				JumpPosition = GetEntityPositionObsoleted(AttackTarget);
			}
			yield return CrossJump(JumpPosition, 0, 0.45);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			break;
		case 5:
			BeginAttack(25, Jump_Combo);
			yield return WaitCustomEvent("CrossJump");
			StopDash();
			RemainDistance = MaxDashDistance - Distance(GetPosition(), StartPosition) - DashSpeed * 0.5;
			yield return CrossJump(TransLocalPosToWorldPos(GetPosition(), GetForward(), GetTSVector2(0, DashJumpSpeed * 0.5)), 0, 0.5);
			if (RemainDistance > 0)
			{
				WaitLookAt_NoWait(AttackTarget, 999, 30);
				BeginDashActorForward(25, DashSpeed, RemainDistance, DashRotateSpeed, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
				yield return WaitDashFinish();
			}
			SkillAnotherTime = true;
			break;
		case 4:
			StopDash();
			BeginAttack(24, End4_Throw_Combo);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			break;
		case 3:
			StopDash();
			BeginAttack(23, End3_Attack_Combo);
			BeginDashActorForward(23, BrakeSpeed, 99, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitCustomEvent("StopDash");
			StopDash();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			break;
		}
	}

	protected override void OnDashFinish(int index)
	{
		if (index == 1)
		{
			FirstDashEnd = true;
		}
	}
}
