using System.Collections;

namespace AIScript.Monster._50171BingXiangGuai_V3;

public class Skill02_NormalAttack_Circle : SkillSimpleBase
{
	private string NormalAttackCircle_Lv1 = "NormalAttackCircle_Lv1";

	private string NormalAttackCircle_Lv2 = "NormalAttackCircle_Lv2";

	protected override IEnumerator DoMainLogic()
	{
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			BeginAttack(3, NormalAttackCircle_Lv2, flushInputedKeys: true, forceInterruptAttack: true);
		}
		else
		{
			BeginAttack(4, NormalAttackCircle_Lv1, flushInputedKeys: true, forceInterruptAttack: true);
		}
		yield return WaitTime(0.8);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
