using System.Collections;
using TrueSync;

namespace AIScript.Monster._Common._70031Huochui;

public class Skill_Call : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.V,
		ComboInputBuffer.ActionKey._2
	};

	private LogicEntity AttackTarget;

	private static readonly string EndAction_Event = "EndAction";

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey1);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		Skill_Call skill_Call = this;
		TSVector2 position = GetPosition();
		FP radius = 6;
		FP innerRadius = 3;
		FP angle = 45;
		FP rotation = GetRotation();
		DeterministicShape shapeData = skill_Call.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		SummonTeammate(1, shapeRandomPoint, GetEntityPosition(AttackTarget), 1);
		yield return WaitCustomEvent(EndAction_Event);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
