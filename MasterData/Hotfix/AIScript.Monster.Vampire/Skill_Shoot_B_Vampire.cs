using System.Collections;
using TrueSync;

namespace AIScript.Monster.Vampire;

public class Skill_Shoot_B_Vampire : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	protected override IEnumerator DoMainLogic()
	{
		Skill_Shoot_B_Vampire skill_Shoot_B_Vampire = this;
		Skill_Shoot_B_Vampire skill_Shoot_B_Vampire2 = this;
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		FP radius = 5;
		FP innerRadius = 0;
		TSVector2 shapeRandomPoint = skill_Shoot_B_Vampire.GetShapeRandomPoint(skill_Shoot_B_Vampire2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius, innerRadius), GetCurrentPlayer(), isReachable: true);
		BeginLookAtByPos(shapeRandomPoint, 2, 150);
		BeginAttack(1, Attack01, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
