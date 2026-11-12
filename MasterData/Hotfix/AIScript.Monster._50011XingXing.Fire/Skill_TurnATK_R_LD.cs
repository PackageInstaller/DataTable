using System.Collections;

namespace AIScript.Monster._50011XingXing.Fire;

public class Skill_TurnATK_R_LD : SkillSimpleBase
{
	private static readonly string WarningFx = "fx_common_base_charge_fire_actor";

	private static readonly int ATKRIndex = 0;

	private static readonly string ATKRKey = "TurnAttack_R";

	private LogicEntity Target;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget(isUpToDate: true)))
		{
			Target = GetAttackTarget(isUpToDate: true);
		}
		else
		{
			Target = GetCurrentPlayer();
		}
		BeginAttack(ATKRIndex, ATKRKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
