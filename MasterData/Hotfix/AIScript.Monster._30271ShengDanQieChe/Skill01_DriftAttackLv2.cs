using System.Collections;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill01_DriftAttackLv2 : SkillSimpleBase
{
	private string DriftLv2 = "DriftLv2";

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, DriftLv2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		GetEnemy();
		yield return BeginLookAt(Targetenemy, 0.5, 720);
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
