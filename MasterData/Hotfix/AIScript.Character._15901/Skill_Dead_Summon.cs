using System.Collections;

namespace AIScript.Character._15901;

public class Skill_Dead_Summon : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Out";

	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
