using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._10006QingXiao;

public class Skill_RunAway_API : SkillSimpleBase
{
	private readonly FP _rotateSpeed = 130;

	private readonly FP _duration = 0.8;

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		LogicEntity attackTarget = GetAttackTarget();
		TSVector2 targetPos = new TSVector2(0, 0);
		BeginLookAtByPos_NotWait(targetPos, _duration, _rotateSpeed);
		AimAtTarget(attackTarget, 90);
		TSVector2 normalized = (_actor.tsTransform.Position - attackTarget.tsTransform.Position).normalized;
		DeterministicShape deterministicFanShape = CommonUtils.GetDeterministicFanShape(8, 5, 180, _actor.tsTransform.Position, normalized.GetAngle());
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(deterministicFanShape, _actor, isReachable: true);
		MoveToPosition(shapeRandomPoint, 0.1f);
	}
}
