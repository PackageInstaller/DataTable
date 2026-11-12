using System.Collections;
using TrueSync;

namespace AIScript.Monster._50001DaShou;

public class Skill_ToRandomPoint2 : SkillSimpleBase
{
	private static readonly FP Radius = 8;

	private static readonly FP InnerRadius = 6;

	private static readonly FP Angle = 36;

	private static readonly FP RectWidth = 3;

	private LogicEntity CenterTarget;

	private TSVector2 TargetPos;

	private TSVector2 MoveCenterPos;

	private FP TargetDis;

	private FP MoveTime;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopMove();
	}

	protected override void OnSkillEnable()
	{
		CenterTarget = ((GetAttackTarget() == null) ? GetAttackTarget() : _actor);
		MoveCenterPos = GetEntityPositionObsoleted(CenterTarget);
		TSVector2 moveCenterPos = MoveCenterPos;
		FP radius = Radius;
		FP innerRadius = InnerRadius;
		FP angle = Angle;
		FP randomValue = GetRandomValue(0, 360);
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, moveCenterPos, default, default, radius, innerRadius, angle, randomValue);
		TargetPos = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		TSVector2 position = GetPosition();
		FP length = Distance(TargetPos, MoveCenterPos);
		for (int i = 0; i < 10; i++)
		{
			FP fP = Distance(TargetPos, position);
			FP tSVectToAngle = GetTSVectToAngle(TargetPos - MoveCenterPos, 0);
			TSVector2 position2 = (TargetPos + MoveCenterPos) / 2;
			FP rectWidth = RectWidth;
			randomValue = tSVectToAngle;
			DeterministicShape shapeData2 = GetShapeData(DeterministicShape.ShapeType.Rectangle, position2, rectWidth, length, default, default, default, randomValue);
			if (AreaCheckObstacle(shapeData2) || !(fP > 4))
			{
				TargetPos = RotateTo(TargetPos - MoveCenterPos, Angle) + MoveCenterPos;
				continue;
			}
			break;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		MoveToPosition(TargetPos, 2);
		yield return WaitTime(1);
		yield return WaitMoveStatus();
	}
}
