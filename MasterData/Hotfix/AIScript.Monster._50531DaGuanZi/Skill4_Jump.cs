#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50531DaGuanZi;

internal class Skill4_Jump : SkillSimpleBase
{
	private static readonly FP DashSpeed = 30;

	private static readonly ComboInputBuffer.ActionKey[] ActionKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly string StartDash_Event = "StartDash";

	private DeterministicShape TargetCircle;

	private TSVector2 TargetPos;

	private FP TargetDis;

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget();
	}

	protected override void OnSkillDisable()
	{
		ResetBlockPriority();
	}

	protected override IEnumerator DoMainLogic()
	{
		FP radius;
		if (AttackTarget != null)
		{
			Skill4_Jump skill4_Jump = this;
			Skill4_Jump skill4_Jump2 = this;
			TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(AttackTarget);
			radius = 7;
			FP innerRadius = 6;
			skill4_Jump.TargetCircle = skill4_Jump2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius, innerRadius);
			TargetPos = GetShapeRandomPoint(TargetCircle, _actor, isReachable: true);
		}
		else
		{
			Skill4_Jump skill4_Jump3 = this;
			Skill4_Jump skill4_Jump4 = this;
			TSVector2 position = GetPosition();
			FP innerRadius = 7;
			radius = 6;
			skill4_Jump3.TargetCircle = skill4_Jump4.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, innerRadius, radius);
			TargetPos = GetShapeRandomPoint(TargetCircle, _actor, isReachable: true);
		}
		TargetDis = Distance(GetPosition(), TargetPos);
		TSVector2 targetPos = TargetPos;
		NovaLogger.Debug("=======目标坐标为==========" + targetPos.ToString());
		SetBlockPriorityToStatic();
		BeginAttack(1, ActionKey);
		Skill4_Jump skill4_Jump5 = this;
		TSVector2 targetPos2 = TargetPos;
		radius = GetRotSpdInSkill();
		skill4_Jump5.BeginLookAtByPos(targetPos2, default, radius);
		yield return WaitCustomEvent(StartDash_Event);
		BeginDashActorForward(1, DashSpeed, TargetDis, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		yield return WaitTime(0.1);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
