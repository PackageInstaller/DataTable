using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Boss._Dark._50251ShanDianLieQuan;

public class MiniBoss_Dark_TiaoPu_Plus : SkillSimpleBase
{
	private readonly string StrongJumpAttack = "StrongJumpAttack";

	private readonly ComboInputBuffer.ActionKey[] Move = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private readonly FP JumpTime = 0.35;

	private readonly FP JumpGap = 0.5;

	private readonly FP ShadowDistance = 5;

	private LogicEntity Targetenemy;

	private List<LogicEntity> Shadow = new List<LogicEntity>();

	private DeterministicShape ShadowShape;

	protected override void OnSkillEnable()
	{
		Shadow.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < -15 || CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 15)
		{
			BeginAttack(1, Move, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			yield return BeginLookAt(Targetenemy, 0.3, 240);
		}
		BeginAttack(2, StrongJumpAttack, flushInputedKeys: true);
		PlayEffect("fx_m50251_base_Dark_Atk04_Energy", 1f, 0, GetPosition(), 0, 1f, actorScale: true);
		GetEnemy();
		MiniBoss_Dark_TiaoPu_Plus miniBoss_Dark_TiaoPu_Plus = this;
		MiniBoss_Dark_TiaoPu_Plus miniBoss_Dark_TiaoPu_Plus2 = this;
		TSVector2 entityPosition = GetEntityPosition(Targetenemy);
		FP radius = 8;
		FP innerRadius = 7.9;
		miniBoss_Dark_TiaoPu_Plus.ShadowShape = miniBoss_Dark_TiaoPu_Plus2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			TSVector2 shapeRandomPoint2 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			for (int i = 0; i <= 100; i++)
			{
				if (!(Distance(shapeRandomPoint2, shapeRandomPoint) <= ShadowDistance))
				{
					break;
				}
				shapeRandomPoint2 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			}
			TSVector2 shapeRandomPoint3 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			for (int j = 0; j <= 100; j++)
			{
				if (!(Distance(shapeRandomPoint3, shapeRandomPoint) <= ShadowDistance) && !(Distance(shapeRandomPoint3, shapeRandomPoint2) <= ShadowDistance))
				{
					break;
				}
				shapeRandomPoint3 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			}
			SummonTeammate(1, shapeRandomPoint, GetEntityPosition(Targetenemy) - shapeRandomPoint, 3);
			SummonTeammate(1, shapeRandomPoint2, GetEntityPosition(Targetenemy) - shapeRandomPoint2, 3);
			SummonTeammate(1, shapeRandomPoint3, GetEntityPosition(Targetenemy) - shapeRandomPoint3, 3);
			BeginLookAt_NotWait(Targetenemy, 5, 30);
			yield return WaitTime(JumpGap);
			Shadow.AddRange(GetTargetByTeammateIndex(1));
			StartCor(Shadow_TiaoPu());
			yield return WaitCustomEvent("End");
		}
		else
		{
			TSVector2 shapeRandomPoint4 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			SummonTeammate(1, shapeRandomPoint4, GetEntityPosition(Targetenemy) - shapeRandomPoint4, 1);
			BeginLookAt_NotWait(Targetenemy, 5, 30);
			yield return WaitTime(JumpGap);
			Shadow.AddRange(GetTargetByTeammateIndex(1));
			AddBuffToTarget(Shadow.get_Item(0), 502510012);
			yield return WaitCustomEvent("End");
		}
		PlayEffect("fx_m50251_base_Dark_Atk04_ElectricEnergy");
		CancelAttack();
		GetEnemy();
		yield return WaitCustomEvent("A1");
		StopWaitLookAt();
		Dash();
		BeginLookAt_NotWait(Targetenemy, 2, 180);
		yield return WaitDashFinish();
		StopWaitLookAt();
		DashMove();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(3, Move, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		yield return BeginLookAt(Targetenemy, 2, 60);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	private void Dash()
	{
		BeginDashActorForward(1, GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) / JumpTime, GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true), 0, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}

	private void DashMove()
	{
		BeginDashActorForward(2, 5, 2, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}

	protected IEnumerator Shadow_TiaoPu()
	{
		AddBuffToTarget(Shadow.get_Item(0), 502510012);
		yield return WaitTime(JumpGap);
		AddBuffToTarget(Shadow.get_Item(1), 502510012);
		yield return WaitTime(JumpGap);
		AddBuffToTarget(Shadow.get_Item(2), 502510012);
	}
}
