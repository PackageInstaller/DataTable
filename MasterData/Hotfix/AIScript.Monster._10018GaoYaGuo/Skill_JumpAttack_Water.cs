using System.Collections;
using TrueSync;

namespace AIScript.Monster._10018GaoYaGuo;

public class Skill_JumpAttack_Water : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[2];

	private TSVector2 SelfPos;

	private TSVector2 PlayerPos;

	private FP DashDistance;

	private FP RotateSpeed;

	protected override void OnSkillEnable()
	{
		RotateSpeed = GetRotSpdInSkill();
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
		WaitLookAt_NoWait(GetAttackTarget(), 5, RotateSpeed);
		yield return WaitCustomEvent("StopTurn");
		StopWaitLookAt();
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
		yield return WaitCustomEvent("WaterAreaEffect");
		PlayAreaEffect("AreaEffect_PangPang_Water", GetPosition());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
