using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill13_RunningAway : SkillSimpleBase
{
	private string RunFast = "RunFast";

	private static readonly FP BackPointX = 4;

	private static readonly FP BackPointY = 10;

	private static readonly FP BackBrakeDistance = 0;

	private static readonly FP FrontPointX = 5;

	private static readonly FP FrontPointY = 12;

	private static readonly FP FrontBrakeDistance = 6;

	private static readonly FP DashSpeed = 30;

	private DeterministicShape RunShape;

	private TSVector2 RunPoint;

	private int RunPointIndex;

	private TSVector2 ChosenRunPoint;

	private TSVector2 ShapePositionRatio;

	private int RunMode;

	private TSVector2 StartDashDirection;

	private FP Ratio;

	private List<TSVector2> RunPointList;

	private FP BrakeDistance;

	private long Emoji;

	protected override void OnSkillEnable()
	{
		RunPointList = new List<TSVector2>();
		RunPointIndex = 0;
	}

	protected override void OnSkillDisable()
	{
		StopEffect(Emoji);
	}

	protected override IEnumerator DoMainLogic()
	{
		Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_Run");
		yield return WaitTime(0.5);
		GetRunPoint();
		if (RunMode == 1)
		{
			Ratio = -1;
		}
		else
		{
			Ratio = 1;
		}
		StartDashDirection = GetForward() * -Ratio;
		TSVector2 tSVector = TransLocalPosToWorldPos(ChosenRunPoint, (ChosenRunPoint - GetPosition()) * Ratio, new TSVector2(0, 100));
		FP fP = AngleBetween2TSVector(GetForward(), tSVector - ChosenRunPoint, signed: false);
		BeginAttack(1, RunFast, flushInputedKeys: true, forceInterruptAttack: true);
		BeginDash(1, StartDashDirection, 2, 1, 999, comboWithAttack: false, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		PlayWwiseSound("mon_50801_brake");
		BeginLookAtByPos_NotWait(tSVector, 0.5, fP / 0.5);
		yield return WaitDashFinish();
		TSVector2 DashDirection = ChosenRunPoint - GetPosition();
		FP distance = Distance(GetPosition(), ChosenRunPoint);
		BeginDash(2, DashDirection, DashSpeed, distance, 0, comboWithAttack: false, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		BeginDash(3, DashDirection, 12, BrakeDistance, 999, comboWithAttack: false, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		BeginLookAt_NotWait(GetAttackTarget(), BrakeDistance / 12, 400);
		yield return WaitDashFinish();
		StopEffect(Emoji);
		CancelAttack();
		yield return WaitTime(1);
	}

	private void GetRunPoint()
	{
		ShapePositionRatio = new TSVector2(BackPointX, -BackPointY);
		CheckPositionValid(ShapePositionRatio);
		ShapePositionRatio = new TSVector2(-BackPointX, -BackPointY);
		CheckPositionValid(ShapePositionRatio);
		ShapePositionRatio = new TSVector2(FrontPointX, FrontPointY);
		CheckPositionValid(ShapePositionRatio);
		ShapePositionRatio = new TSVector2(-FrontPointX, FrontPointY);
		CheckPositionValid(ShapePositionRatio);
		if (RunPointList.Count == 0)
		{
			ChosenRunPoint = TSVector2.zero;
		}
		else
		{
			ChosenRunPoint = RunPointList.get_Item(0);
		}
		if (RunPointIndex <= 1)
		{
			BrakeDistance = BackBrakeDistance;
			RunMode = 1;
		}
		else
		{
			BrakeDistance = FrontBrakeDistance;
			RunMode = 2;
		}
	}

	private void CheckPositionValid(TSVector2 ShapePositionRatio)
	{
		TSVector2 entityPosition = GetEntityPosition(GetAttackTarget());
		TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), entityPosition - GetPosition(), ShapePositionRatio);
		FP radius = 1;
		FP innerRadius = 0;
		RunShape = GetShapeData(DeterministicShape.ShapeType.Circle, tSVector, default, default, radius, innerRadius);
		RunPoint = GetShapeRandomPoint(RunShape, _actor, isReachable: true);
		if (RunPoint != tSVector)
		{
			RunPointList.Add(RunPoint);
		}
		else
		{
			RunPointIndex++;
		}
	}
}
