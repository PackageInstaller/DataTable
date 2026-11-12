using System.Collections;

namespace AIScript.Monster._50281LeiSheZhu;

public class Skill_Attack_01 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1];

	private LogicEntity AttackTarget;

	private static readonly string StopAttack = "StopAttack";

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
		BeginLookAt_NotWait(AttackTarget, 0.5, 540);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitCustomEvent(StopAttack);
		CancelAttack();
		BeginLookAt_NotWait(AttackTarget, 2.1, 540);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
