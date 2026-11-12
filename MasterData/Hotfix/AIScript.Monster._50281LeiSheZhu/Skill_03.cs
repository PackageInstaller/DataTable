using System.Collections;

namespace AIScript.Monster._50281LeiSheZhu;

public class Skill_03 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget();
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey);
		BeginLookAtMonsterTarget(8, 120);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		DoDash();
		yield return WaitDashFinish();
		CancelAttack();
		BeginLookAt_NotWait(AttackTarget, 1.8, 540);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 4, 22, 90, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
