using System.Collections;

namespace AIScript.Monster._FuYouJian._70031Huochui;

public class FuYouJian_Attack_01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1
	};

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
		BeginAttack(1, _actionKey1);
		BeginLookAt_NotWait(AttackTarget, 8.8, 240);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		DoDash();
		yield return WaitDashFinish();
		CancelAttack();
		BeginLookAt_NotWait(AttackTarget, 1.8, 540);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		StopDash();
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 4, 12, 90, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
