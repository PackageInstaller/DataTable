using System.Collections;
using TrueSync;

namespace AIScript.Monster._50201WeiBing;

public class Skill_Jump_Daily : SkillSimpleBase
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
		Skill_Jump_Daily skill_Jump_Daily = this;
		Skill_Jump_Daily skill_Jump_Daily2 = this;
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		FP radius = 5;
		FP innerRadius = 0;
		TSVector2 RandomPoint = skill_Jump_Daily.GetShapeRandomPoint(skill_Jump_Daily2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius, innerRadius), GetCurrentPlayer(), isReachable: true);
		BeginLookAtByPos(RandomPoint, 2, 150);
		yield return WaitTime(1);
		BeginAttack(1, Start_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		FP fP = Distance(GetPosition(), RandomPoint) + 5;
		SetCloseBlockEnable();
		BeginDashActorForward(1, DashSpeed, fP, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		FP dashtime = fP / DashSpeed;
		yield return WaitTime(dashtime);
		StopDash();
		BeginAttack(2, End1_JumpAttack_Combo);
		yield return WaitTime(0.3);
		BeginDashActorForward(2, 8, 4, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitTime(0.5);
		StopDash();
		SetCloseBlockDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		AimAtMonsterTarget(120);
		yield return WaitTime(4 - dashtime);
		CancelAim();
	}
}
