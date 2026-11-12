using System.Collections;

namespace AIScript.Monster._50191ZhongGuanZi;

public class Skill1_JumpAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1];

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey);
		BeginLookAt_NotWait(AttackTarget, 5, 540);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		DoDash();
		yield return WaitDashFinish();
		CancelAttack();
		BeginLookAt_NotWait(AttackTarget, 0.5, 540);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 6, 25, 50, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
