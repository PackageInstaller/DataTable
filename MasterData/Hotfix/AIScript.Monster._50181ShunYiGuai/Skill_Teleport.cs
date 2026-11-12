using System.Collections;
using TrueSync;

namespace AIScript.Monster._50181ShunYiGuai;

public class Skill_Teleport : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Walk = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.W };

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity TargetPlayer = GetCurrentPlayer();
		FP tSVectToAngle = GetTSVectToAngle(GetForward(), 0);
		Skill_Teleport skill_Teleport = this;
		TSVector2 position = GetPosition();
		FP radius = 8;
		FP innerRadius = 6;
		FP angle = 180;
		FP rotation = tSVectToAngle;
		DeterministicShape shapeData = skill_Teleport.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		Skill_Teleport skill_Teleport2 = this;
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(TargetPlayer);
		rotation = 8;
		angle = 6;
		innerRadius = 360;
		radius = 0;
		DeterministicShape shapeData2 = skill_Teleport2.GetShapeData(DeterministicShape.ShapeType.Fan, entityPositionObsoleted, default, default, rotation, angle, innerRadius, radius);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		TSVector2 shapeRandomPoint2 = GetShapeRandomPoint(shapeData2, TargetPlayer, isReachable: true);
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < 5)
		{
			MoveToPosition(shapeRandomPoint, 0, AdventureActor.MovementMode.Walk);
			yield return WaitMoveStatus();
			BeginAttack(1, Walk, flushInputedKeys: true);
			BeginLookAt_NotWait(TargetPlayer, 0.4, 240);
			yield return WaitTime(0.2);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			MoveToPosition(shapeRandomPoint2, 0, AdventureActor.MovementMode.Walk);
			yield return WaitMoveStatus();
			BeginAttack(1, Walk, flushInputedKeys: true);
			BeginLookAt_NotWait(TargetPlayer, 0.4, 240);
			yield return WaitTime(0.2);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}
}
