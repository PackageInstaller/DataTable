#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50271FengMeiGuai;

public class Skill_Run : SkillSimpleBase
{
	private TSVector2 targetPOS;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("风媒怪.移动.开始");
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("风媒怪.移动.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		targetPOS = MoveTargetPOS();
		MoveToPosition(targetPOS, 0.5, AdventureActor.MovementMode.Run, 1.5f);
		yield return WaitMoveStatus();
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		yield return BeginLookAt(logicEntity, 0.5, 360);
	}

	private TSVector2 MoveTargetPOS()
	{
		TSVector2 zero = TSVector2.zero;
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		TSVector2 position = GetPosition();
		FP radius = 8;
		FP innerRadius = 4;
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
			FP fP = ((TSRandom.Range(0, 2) != 0) ? 1 : (-1));
			tSVectToAngle = 13;
			angle = 7;
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
}
