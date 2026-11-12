using System.Collections;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_SmallBird_FlyUp : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Fly_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Null_Combo = new ComboInputBuffer.ActionKey[0];

	private TSVector2 BlinkPosition;

	private LogicEntity Target;

	private DeterministicShape AttackShape;

	protected override void OnSkillEnable()
	{
		Target = GetAttackTarget();
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAt_NotWait(Target, 999, 150);
		while (!GetLogicTagToggleValue(_actor, "StartSkill"))
		{
			yield return null;
		}
		StopWaitLookAt();
		yield return WaitTime(0.2);
		BeginAttack(1, Fly_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		while (!GetLogicTagToggleValue(_actor, "StartAttack"))
		{
			yield return null;
		}
		yield return WaitTime(GetLogicTagFpValue(_actor, "WaitAttackTime"));
		Target = GetAttackTarget(isUpToDate: true);
		if (GetLogicTagFpValue(_actor, "AimMode") == 1)
		{
			Skill_SmallBird_FlyUp skill_SmallBird_FlyUp = this;
			Skill_SmallBird_FlyUp skill_SmallBird_FlyUp2 = this;
			TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(Target);
			FP radius = 4;
			FP innerRadius = 2;
			FP angle = 60;
			FP entityAngle = GetEntityAngle(Target);
			skill_SmallBird_FlyUp.AttackShape = skill_SmallBird_FlyUp2.GetShapeData(DeterministicShape.ShapeType.Fan, entityPositionObsoleted, default, default, radius, innerRadius, angle, entityAngle);
		}
		else
		{
			Skill_SmallBird_FlyUp skill_SmallBird_FlyUp3 = this;
			Skill_SmallBird_FlyUp skill_SmallBird_FlyUp4 = this;
			TSVector2 entityPositionObsoleted2 = GetEntityPositionObsoleted(Target);
			FP entityAngle = 2;
			FP angle = 0;
			skill_SmallBird_FlyUp3.AttackShape = skill_SmallBird_FlyUp4.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted2, default, default, entityAngle, angle);
		}
		BlinkPosition = GetShapeRandomPoint(AttackShape, _actor, isReachable: true);
		Blink_NotWait(Null_Combo, BlinkPosition, 0, null, 0, null, 0, GetAttackTarget(isUpToDate: true));
		yield return null;
		PlayEarlyWarningEffect("FlyupWarning", 0.8f, 0, BlinkPosition, default, 0.5f);
		CancelAttack();
		yield return WaitCustomEvent("Die");
		_actor.DestroySelf();
	}
}
