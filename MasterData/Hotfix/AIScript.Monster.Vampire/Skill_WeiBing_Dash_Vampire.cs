using System.Collections;
using TrueSync;

namespace AIScript.Monster.Vampire;

public class Skill_WeiBing_Dash_Vampire : SkillSimpleBase
{
	private static readonly FP DashSpeed = 10;

	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] End1_JumpAttack_Combo = new ComboInputBuffer.ActionKey[1];

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		Skill_WeiBing_Dash_Vampire skill_WeiBing_Dash_Vampire = this;
		Skill_WeiBing_Dash_Vampire skill_WeiBing_Dash_Vampire2 = this;
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		FP radius = 5;
		FP innerRadius = 0;
		TSVector2 shapeRandomPoint = skill_WeiBing_Dash_Vampire.GetShapeRandomPoint(skill_WeiBing_Dash_Vampire2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius, innerRadius), GetCurrentPlayer(), isReachable: true);
		BeginLookAtByPos(shapeRandomPoint, 2, 150);
		BeginAttack(1, Start_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		FP fP = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) - 2;
		BeginDashActorForward(1, DashSpeed, fP, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitTime(fP / DashSpeed);
		StopDash();
		BeginAttack(2, End1_JumpAttack_Combo);
		yield return WaitTime(0.3);
		BeginDashActorForward(2, 8, 4, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitTime(0.5);
		StopDash();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
