using System.Collections;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class ToRandomPoint : SkillSimpleBase
{
	private TSVector2 TargetPosition;

	private CoroutineNode CheckDistanceNode;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		StopMove();
	}

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetAttackTarget());
		ToRandomPoint toRandomPoint = this;
		FP radius = 8;
		FP innerRadius = 5;
		FP angle = 150;
		FP tSVectToAngle = GetTSVectToAngle(GetPosition() - entityPositionObsoleted, 0);
		DeterministicShape shapeData = toRandomPoint.GetShapeData(DeterministicShape.ShapeType.Fan, entityPositionObsoleted, default, default, radius, innerRadius, angle, tSVectToAngle);
		TargetPosition = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		int num = 0;
		while (Distance(TargetPosition, GetPosition()) <= 3 && num <= 5)
		{
			TargetPosition = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			num++;
		}
		yield return BeginLookAtMonsterTarget(1, 180, 30);
		AimAtMonsterTarget(45);
		MoveToPosition(TargetPosition, 0.1, AdventureActor.MovementMode.Walk);
		yield return WaitMoveStatus();
		CancelAim();
		StopCor(CheckDistanceNode);
		yield return WaitTime(1);
	}
}
