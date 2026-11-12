using System.Collections;

namespace AIScript.Monster._14901001TieChuNv;

public class SkillScript_Death : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Die";

	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
