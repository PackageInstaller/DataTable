using System.Collections;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_Spawn : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Spawn", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
