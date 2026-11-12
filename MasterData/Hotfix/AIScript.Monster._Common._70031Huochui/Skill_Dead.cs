using System.Collections;

namespace AIScript.Monster._Common._70031Huochui;

public class Skill_Dead : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

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
		SendDeclareDeadEvent();
		BeginAttack(1, _actionKey1);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(2);
		CancelAttack();
		yield return WaitTime(0.66);
		SetHideModelEnable();
	}
}
