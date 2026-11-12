using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._50011XingXing.Nothing;

public class Skill_TurnATK_L_LD : SkillBaseXingXing
{
	private LogicEntity Target;

	private static readonly string WarningFx_ATKL = "fx_m50011_base_skill4_hint_L_nothing";

	private static readonly string Charge_ATKL = "fx_m50011_loop_skill4_charge_Rhand_L_nothing";

	private static readonly string hitFx = "fx_common_hit_common_strike";

	private List<long> _ATKLFx = new List<long>();

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
		BeginAttack(SkillBaseXingXing.ATKLIndex, SkillBaseXingXing.ATKLKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
