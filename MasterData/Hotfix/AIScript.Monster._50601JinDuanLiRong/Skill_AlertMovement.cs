#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_AlertMovement : JinDuanLiRongSkillBase
{
	private TSVector2 targetPOS;

	private LogicEntity target;

	private string alertTypeName = "AlertType";

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("禁断丽容.移动.开始");
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("禁断丽容.移动.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		targetPOS = MoveTargetPOS();
		target = GetTarget();
		switch ((int)(long)GetLogicTagFpValue(_actor, alertTypeName))
		{
		case 0:
			yield return StartCor(AlertMove());
			break;
		case 1:
			yield return StartCor(AlertLookAt());
			break;
		default:
			NovaLogger.Debug("禁断丽容.警戒行为.警戒类型逻辑标签异常,默认移动");
			yield return StartCor(AlertMove());
			break;
		}
	}

	private IEnumerator AlertMove()
	{
		AimAtTarget(target, 180);
		MoveToPosition(targetPOS, 0.5, AdventureActor.MovementMode.Walk, 4f);
		yield return WaitMoveStatus();
		CancelAim();
	}

	private IEnumerator AlertLookAt()
	{
		BeginAttack(JinDuanLiRongSkillBase.idleIndex, JinDuanLiRongSkillBase.idle2Key, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 99, 180);
		yield return WaitTime(GetRandomValue(1.5, 2.5));
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopLookAt();
	}

	private TSVector2 MoveTargetPOS()
	{
		TSVector2 zero = TSVector2.zero;
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		TSVector2 position = GetPosition();
		FP radius = 12;
		FP innerRadius = 9;
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
			angle = 9;
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
