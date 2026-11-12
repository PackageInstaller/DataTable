using System.Collections;

namespace AIScript.Monster._50171BingXiangGuai_V3;

public class Skill02_NormalAttack_Fan : SkillSimpleBase
{
	private string NormalAttackFan90_Lv1 = "NormalAttackFan90_Lv1";

	private string NormalAttackFan180_Lv2 = "NormalAttackFan180_Lv2";

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			BeginAttack(1, NormalAttackFan180_Lv2, flushInputedKeys: true, forceInterruptAttack: true);
		}
		else
		{
			BeginAttack(2, NormalAttackFan90_Lv1, flushInputedKeys: true, forceInterruptAttack: true);
		}
		yield return WaitCustomEvent("T1");
		GetEnemy();
		yield return BeginLookAt(Targetenemy, 2, 90);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
