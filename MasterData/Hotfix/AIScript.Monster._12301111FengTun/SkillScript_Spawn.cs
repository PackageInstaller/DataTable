using System.Collections;

namespace AIScript.Monster._12301111FengTun;

public class SkillScript_Spawn : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Birth";

	protected override IEnumerator DoMainLogic()
	{
		_actor.EnableCloseBlock();
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
