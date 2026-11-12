#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50521TiaoWuJi;

public class Skill_AlertMovement : SkillSimpleBase
{
	private TSVector2 targetPOS;

	private LogicEntity target;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("跳舞机.移动.开始");
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("跳舞机.移动.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		targetPOS = MoveTargetPOS();
		target = GetTarget();
		AimAtTarget(target, 180);
		MoveToPosition(targetPOS, 0.5, AdventureActor.MovementMode.Walk, 5f);
		yield return WaitMoveStatus();
		CancelAim();
	}

	private TSVector2 MoveTargetPOS()
	{
		TSVector2 zero = TSVector2.zero;
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		TSVector2 position = GetPosition();
		FP radius = 12;
		FP innerRadius = 6;
		FP angle = 60;
		FP tSVectToAngle = GetTSVectToAngle(position - entityPositionObsoleted, 0);
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, tSVectToAngle);
		for (int i = 0; i < 5; i++)
		{
			zero = GetShapeRandomPoint(shapeData, _actor);
			if (QueryPositionReachable(_actor, zero) && Distance(entityPositionObsoleted, zero) >= 4)
			{
				return zero;
			}
		}
		for (int j = 0; j < 5; j++)
		{
			FP fP = ((!(GetRandomValue(0, 1) < 0.5)) ? 1 : (-1));
			tSVectToAngle = 12;
			angle = 6;
			innerRadius = 15;
			radius = GetTSVectToAngle(entityPositionObsoleted - position, 40 * fP);
			shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, tSVectToAngle, angle, innerRadius, radius);
			zero = GetShapeRandomPoint(shapeData, _actor);
			if (QueryPositionReachable(_actor, zero) && Distance(entityPositionObsoleted, zero) >= 4)
			{
				return zero;
			}
		}
		return TSVector2.zero;
	}

	protected LogicEntity GetTarget()
	{
		LogicEntity result = GetAttackTarget();
		if (!CheckTargetIsValid(result))
		{
			result = GetCurrentPlayer();
		}
		return result;
	}
}
