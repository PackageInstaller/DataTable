using System.Collections;

namespace AIScript.Monster._FuYouJian._70031Huochui;

public class FuYouJian_Spawn : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.F,
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
		SetBattleOutEnable();
		SetSearchedImmunityEnable();
		SetImmuneControlEnable();
		SetCloseBlockEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey1, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		SetBattleOutDisable();
		SetSearchedImmunityDisable();
		SetImmuneControlDisable();
		SetCloseBlockDisable();
	}
}
