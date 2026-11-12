using System.Collections;

namespace AIScript.Monster._16011YuanChengFengCao;

public class Skill_pollen : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly string pollenfx = "AreaEffect_16011YuanChengFengCao_pollen";

	private static readonly string sharkfx = "FX/Perk/fx_perk_base_water_shark_normal";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		GetAttackTarget();
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
