using System.Collections;

namespace AIScript.Monster._30931HaSaNa_MiniBoss;

public class Skill_Spawn : SkillSimpleBase
{
	private string Spawn_Combo = "Spawn";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetHideModelEnable();
		SetUnparalleledEnable();
		ModelNodeShow("ShaJuRen", isShow: false);
		ModelNodeShow("ShaJuRen_trans", isShow: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		PlayEffect("fx_m30901_base_sandborn", 1f, 0, GetPosition(), default, 1.4f);
		yield return WaitTime(1);
		BeginAttack(1, Spawn_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		SetHideModelDisable();
		ShowBlood(isShow: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		ShowCenterHpBar();
	}
}
