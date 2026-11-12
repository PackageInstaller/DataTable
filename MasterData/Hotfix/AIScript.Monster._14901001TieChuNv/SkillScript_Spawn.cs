using System.Collections;

namespace AIScript.Monster._14901001TieChuNv;

public class SkillScript_Spawn : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Birth";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
