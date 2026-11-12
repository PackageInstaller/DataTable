using System.Collections;

namespace AIScript.Monster._12301111FengTun;

public class SkillScript_Death : SkillSimpleBase
{
	private readonly int keyIndex = 1;

	private readonly string key = "Death";

	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
