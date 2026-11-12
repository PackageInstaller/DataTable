using System.Collections;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_Born_XianJingPatrol : SkillSimpleBase
{
	private const string combo_Born = "Born";

	protected override void OnSkillEnable()
	{
		SetUnparalleledEnable();
		SetCloseBlockEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "Born", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
