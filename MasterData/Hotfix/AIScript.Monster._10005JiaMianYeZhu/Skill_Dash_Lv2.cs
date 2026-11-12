using System.Collections;
using TrueSync;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Skill_Dash_Lv2 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Dash_Combo_Normal = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Dash_Combo_Fast = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	private static readonly ComboInputBuffer.ActionKey[] Dash_Combo_Second = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.J };

	private static readonly FP DashDistanceExtra = 6;

	private static readonly FP DashDistanceNoTarget = 15;

	private static readonly FP DashSpeedNormal = 18;

	private static readonly FP DashSpeedFast = 21;

	private static readonly FP TurnLimitInP2 = 1.5;

	private static readonly FP BrakeDashSpeed = 7.5;

	private static readonly FP BrakeDashDistance = 4;

	private FP TurnSpeed;

	private FP BrakeDashTurnSpeed;

	private ComboInputBuffer.ActionKey[] Dash_Combo;

	private bool CanTrace;

	private FP DashSpeed;

	private FP DashDistance;

	protected override void OnSkillEnable()
	{
		if (GetBuffNum(_actor, 100050110) > 0)
		{
			TurnSpeed = 65;
			Dash_Combo = Dash_Combo_Fast;
			CanTrace = true;
			DashSpeed = DashSpeedFast;
		}
		else
		{
			TurnSpeed = 40;
			Dash_Combo = Dash_Combo_Normal;
			CanTrace = false;
			DashSpeed = DashSpeedNormal;
		}
		BrakeDashTurnSpeed = 300;
	}

	protected override void OnSkillDisable()
	{
		StopWaitLookAt();
		RemoveBuffFromTarget(_actor, 990020140);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Dash_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetAttackTarget(), 999, TurnSpeed);
		yield return WaitCustomEvent("TurnEnd");
		StopWaitLookAt();
		Skill_Dash_Lv2 skill_Dash_Lv = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Dash_Lv.PlayEarlyWarningEffect("DashWarning", 1f, default, position, rotation);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		if (CanTrace)
		{
			BeginLookAt_NotWait(GetAttackTarget(), 999, TurnSpeed);
		}
		GetDashDistance();
		AddBuffToTarget(_actor, 990020140);
		BeginDashActorForward(1, DashSpeed, DashDistance, TurnLimitInP2, comboWithAttack: true, CanTrace, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		RemoveBuffFromTarget(_actor, 990020140);
		CancelAttack();
		StopWaitLookAt();
		if (CanTrace)
		{
			BeginLookAt_NotWait(GetAttackTarget(isUpToDate: true), 0, BrakeDashTurnSpeed);
		}
		BeginDashActorForward(2, BrakeDashSpeed, BrakeDashDistance, 0, comboWithAttack: true, CanTrace, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		if (CanTrace)
		{
			Skill_Dash_Lv2 skill_Dash_Lv2 = this;
			position = GetPosition();
			rotation = GetRotation();
			skill_Dash_Lv2.PlayEarlyWarningEffect("DashWarning", 1f, default, position, rotation);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (CanTrace)
		{
			AddBuffToTarget(_actor, 990020140);
			BeginAttack(2, Dash_Combo_Second, flushInputedKeys: true, forceInterruptAttack: true);
			BeginLookAt_NotWait(GetAttackTarget(), 999, TurnSpeed);
			GetDashDistance();
			BeginDashActorForward(3, DashSpeed, DashDistance, TurnLimitInP2, comboWithAttack: true, CanTrace, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitDashFinish();
			RemoveBuffFromTarget(_actor, 990020140);
			CancelAttack();
			StopWaitLookAt();
			BeginDashActorForward(2, BrakeDashSpeed, BrakeDashDistance, 0, comboWithAttack: true, CanTrace, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private void GetDashDistance()
	{
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			DashDistance = Distance(GetPosition(), GetEntityPositionObsoleted(GetAttackTarget())) + DashDistanceExtra;
		}
		else
		{
			DashDistance = DashDistanceNoTarget;
		}
	}
}
