using System.Collections;

namespace AIScript.Monster._1st._70031Huochui;

public class Skill_HuiXuanGuangRen : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.C,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string StopAttack_Event = "StopAttack";

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
		BeginAttack(1, _actionKey1);
		BeginLookAt_NotWait(AttackTarget, 5, 240);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		for (int i = 0; i < 1; i++)
		{
			yield return WaitCustomEvent(StopAttack_Event);
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
