using System.Collections;
using TrueSync;

namespace AIScript.Monster._10018GaoYaGuo;

public class Skill_JumpAttack_Fire : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	private TSVector2 SelfPos;

	private TSVector2 PlayerPos;

	private FP DashDistance;

	private FP RotateSpeed;

	private long LoopFXID;

	protected override void OnSkillEnable()
	{
		RotateSpeed = GetRotSpdInSkill();
		SetBlockPriorityToStatic();
	}

	protected override void OnSkillDisable()
	{
		StopEffect(LoopFXID);
		RemoveBuffFromTarget(_actor, 990020140);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack_Combo, flushInputedKeys: true);
		yield return WaitCustomEvent("Turn");
		WaitLookAt_NoWait(GetAttackTarget(), 99, RotateSpeed);
		LoopFXID = PlayEffect("fx_10018_loop_Ready_Loop_fire");
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.5);
		StopWaitLookAt();
		StopEffect(LoopFXID);
		BeginAttack(1, Attack_Combo);
		yield return WaitCustomEvent("Jump");
		SetCloseBlockEnable();
		SetSearchedImmunityEnable();
		AddBuffToTarget(_actor, 990020140);
		LogicEntity attackTarget = GetAttackTarget();
		if (CheckTargetIsValid(attackTarget))
		{
			SelfPos = GetPosition();
			PlayerPos = GetEntityPosition(attackTarget);
			DashDistance = Distance(PlayerPos, SelfPos);
			DashDistance = TSMath.Clamp(DashDistance, 5, 8);
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
