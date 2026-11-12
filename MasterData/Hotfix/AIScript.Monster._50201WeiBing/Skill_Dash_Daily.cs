using System.Collections;
using TrueSync;

namespace AIScript.Monster._50201WeiBing;

public class Skill_Dash_Daily : SkillSimpleBase
{
	private static readonly FP DashSpeed = 10;

	private static readonly FP BrakeSpeed = 7;

	private static readonly FP DashRotateSpeed = 30;

	private static readonly FP DashJumpSpeed = 10;

	private static readonly FP MaxDashDistance = 9;

	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] End3_Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		GetAttackTarget();
		Skill_Dash_Daily skill_Dash_Daily = this;
		Skill_Dash_Daily skill_Dash_Daily2 = this;
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		FP radius = 5;
		FP innerRadius = 0;
		TSVector2 shapeRandomPoint = skill_Dash_Daily.GetShapeRandomPoint(skill_Dash_Daily2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius, innerRadius), GetCurrentPlayer(), isReachable: true);
		BeginLookAtByPos(shapeRandomPoint, 2, 150);
		yield return WaitTime(1);
		StopWaitLookAt();
		BeginAttack(1, Start_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginDashActorForward(1, DashSpeed, MaxDashDistance, DashRotateSpeed, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		FP dashtime = MaxDashDistance / DashSpeed;
		yield return WaitTime(dashtime);
		StopDash();
		BeginAttack(23, End3_Attack_Combo);
		BeginDashActorForward(23, BrakeSpeed, 99, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCustomEvent("StopDash");
		StopDash();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		AimAtMonsterTarget(120);
		yield return WaitTime(4 - dashtime);
		CancelAim();
	}
}
