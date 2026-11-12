using System.Collections;

namespace AIScript.Monster._72016KuiLeiJuNu;

public class Skill_JianShiZhuangTian : SkillSimpleBase
{
	private const string combo_ZhuangTian = "Reload";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "Reload", flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
