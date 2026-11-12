using System.Collections;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill01_DriftAttackLv1 : SkillSimpleBase
{
	private string DriftLv1 = "DriftLv1";

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, DriftLv1, flushInputedKeys: true, forceInterruptAttack: true);
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
