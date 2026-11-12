using System.Collections;

namespace AIScript.Monster._50531DaGuanZi;

public class Skill6_JumpAttack2 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	private LogicEntity attackTarget;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ResetBlockPriority();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			attackTarget = GetAttackTarget();
		}
		else
		{
			attackTarget = GetCurrentPlayer();
		}
		SetBlockPriorityToStatic();
		yield return BeginLookAt(attackTarget, 0.3, 600);
		BeginAttack(1, startKey, flushInputedKeys: true);
		yield return WaitCustomEvent("StartDash");
		DoDash();
		yield return WaitDashFinish();
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 60, 30, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false, 0.5);
	}
}
