using System.Collections;
using TrueSync;

namespace AIScript.Monster._10018GaoYaGuo;

public class Skill_JumpAttack_Dark : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[2];

	private static readonly ComboInputBuffer.ActionKey[] Attack_Another_Combo = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey.B
	};

	private TSVector2 SelfPos;

	private TSVector2 PlayerPos;

	private FP DashDistance;

	private FP RotateSpeed;

	private LogicEntity Target;

	protected override void OnSkillEnable()
	{
		RotateSpeed = GetRotSpdInSkill();
		Target = GetAttackTarget();
		SetBlockPriorityToStatic();
	}

	protected override void OnSkillDisable()
	{
		RemoveBuffFromTarget(_actor, 990020140);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack_Combo, flushInputedKeys: true);
		yield return WaitCustomEvent("Turn");
		WaitLookAt_NoWait(Target, 5, RotateSpeed);
		yield return WaitCustomEvent("StopTurn");
		StopWaitLookAt();
		yield return WaitCustomEvent("Jump");
		SetCloseBlockEnable();
		SetSearchedImmunityEnable();
		AddBuffToTarget(_actor, 990020140);
		if (CheckTargetIsValid(Target))
		{
			SelfPos = GetPosition();
			PlayerPos = GetEntityPosition(Target);
			DashDistance = Distance(PlayerPos, SelfPos);
			DashDistance = TSMath.Clamp(DashDistance, DashDistance, 8);
			BeginDashActorForward(1, 20, DashDistance, 30, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitDashFinish();
		}
		BeginAttack(1, Attack_Combo);
		yield return WaitCustomEvent("BuffDelete");
		SetCloseBlockDisable();
		SetSearchedImmunityDisable();
		RemoveBuffFromTarget(_actor, 990020140);
		yield return WaitCustomEvent("FastEnd");
		Target = GetAttackTarget(isUpToDate: true);
		WaitLookAt_NoWait(Target, 5, RotateSpeed * 5);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopWaitLookAt();
		BeginAttack(2, Attack_Another_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Turn");
		WaitLookAt_NoWait(Target, 5, RotateSpeed);
		yield return WaitCustomEvent("StopTurn");
		StopWaitLookAt();
		yield return WaitCustomEvent("Jump");
		SetCloseBlockEnable();
		SetSearchedImmunityEnable();
		AddBuffToTarget(_actor, 990020140);
		if (CheckTargetIsValid(Target))
		{
			SelfPos = GetPosition();
			PlayerPos = GetEntityPosition(Target);
			DashDistance = Distance(PlayerPos, SelfPos);
			DashDistance = TSMath.Clamp(DashDistance, DashDistance, 8);
			BeginDashActorForward(1, 20, DashDistance, 30, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitDashFinish();
		}
		CancelAttack();
		yield return WaitCustomEvent("BuffDelete");
		SetCloseBlockDisable();
		SetSearchedImmunityDisable();
		RemoveBuffFromTarget(_actor, 990020140);
		ResetBlockPriority();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
