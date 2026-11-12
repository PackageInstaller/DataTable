using System.Collections;
using TrueSync;

namespace AIScript.Monster._16001JinZhanFengCao;

public class Skill_TraceCharge : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected readonly FP dash_spd = 4;

	protected readonly FP dash_angleLimit = 60;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		BeginLookAt_NotWait(target, 0.4, 120);
		yield return WaitTime(0.4);
		BeginAttack(1, Start_Combo, flushInputedKeys: true);
		_actor.DistanceWithRadius(target);
		FP time = GetRandomValue(1, 3);
		yield return WaitTime(1.1);
		while (time > 0)
		{
			time -= (FP)0.2f;
			BeginTrace(target, 3, -1, 0.2);
			yield return WaitTime(0.2);
		}
		yield return WaitTime(GetRandomValue(1, 2));
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		TSVector2 position = GetPosition();
		Skill_TraceCharge skill_TraceCharge = this;
		FP radius = 6;
		FP innerRadius = 3;
		FP angle = 240;
		FP rotation = 180;
		DeterministicShape shapeData = skill_TraceCharge.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, target, isReachable: true);
		MoveToPosition(shapeRandomPoint, 1);
		yield return WaitMoveStatus();
		yield return WaitTime(1);
	}
}
