using System.Collections;
using TrueSync;

namespace AIScript.Monster._50241ShiZiDao;

public class ToRandomPoint : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[2];

	private TSVector2 TargetPosition;

	private CoroutineNode CheckDistanceNode;

	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakSkill", value: true);
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakSkill", value: false);
		StopMove();
		StopWaitLookAt();
	}

	protected override IEnumerator DoMainLogic()
	{
		while (true)
		{
			TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetAttackTarget());
			ToRandomPoint toRandomPoint = this;
			FP radius = 5;
			FP innerRadius = 2;
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
			yield return BeginLookAtByPos(TargetPosition, 0, 100);
			MoveToPosition(TargetPosition, 0.1);
			StartCor(ref CheckDistanceNode, CheckDistance());
			yield return WaitMoveStatus();
			StopCor(CheckDistanceNode);
			yield return WaitTime(1);
		}
	}

	private IEnumerator CheckDistance()
	{
		while (Distance(GetEntityPositionObsoleted(GetAttackTarget(isUpToDate: true)), TargetPosition) <= 5)
		{
			yield return null;
		}
		StopMove();
	}
}
