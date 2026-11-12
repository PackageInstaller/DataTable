using System.Collections;

namespace AIScript.Monster._1st._70031Huochui;

public class Skill_GuangRenTouZhi : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string StopLookAT_Event = "StopLookAt";

	private static readonly string StartLookAt_Event = "StartLookAt";

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
		BeginLookAt_NotWait(AttackTarget, 1, 540);
		yield return WaitTime(1);
		BeginAttack(1, _actionKey1, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
