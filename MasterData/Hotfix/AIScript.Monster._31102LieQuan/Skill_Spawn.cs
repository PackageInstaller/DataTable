using System.Collections;

namespace AIScript.Monster._31102LieQuan;

public class Skill_Spawn : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		PlayEffect("fx_m31102_base_born", 1f, default, GetPosition(), GetEntityAngle(_actor), 1.5f);
		yield return WaitTime(0.6);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
