using System.Collections;
using TrueSync;

namespace AIScript.Monster._50201WeiBing;

public class Skill_Dash_Down_Daily : SkillSimpleBase
{
	private static readonly FP DashSpeed = 10;

	private static readonly FP BrakeSpeed = 7;

	private static readonly FP DashRotateSpeed = 30;

	private static readonly FP DashJumpSpeed = 10;

	private static readonly FP MaxDashDistance = 9;

	private readonly string fx_Alias = "fx_switch_monster_actor";

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
		SetHideOutEnable();
		SetHideModelEnable();
		SetImmuneControlEnable();
		PlayEffect(fx_Alias, 1f, default, GetPosition(), GetEntityAngle(_actor));
		yield return WaitTime(1);
		SetImmuneControlDisable();
		SetHideModelDisable();
		SetHideOutDisable();
		BeginLookAtCameraDir(DirectionType.Down, 0, 700);
		yield return WaitTime(1);
		BeginAttack(1, Start_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginDashActorForward(1, DashSpeed, MaxDashDistance, DashRotateSpeed, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		FP waitSeconds = MaxDashDistance / DashSpeed;
		yield return WaitTime(waitSeconds);
		StopDash();
		BeginAttack(23, End3_Attack_Combo);
		BeginDashActorForward(23, BrakeSpeed, 99, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCustomEvent("StopDash");
		StopDash();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
