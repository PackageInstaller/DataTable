using System.Collections;

namespace AIScript.Monster._Common._70031Huochui;

public class Skill_ToHot : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.X,
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
		SetLockToughnessEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey1);
		BeginLookAt_NotWait(AttackTarget, 8, 360);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitCustomEvent(StopAttack_Event);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetLockToughnessDisable();
	}

	protected override void OnSkillDisable()
	{
		SetLockToughnessDisable();
	}
}
