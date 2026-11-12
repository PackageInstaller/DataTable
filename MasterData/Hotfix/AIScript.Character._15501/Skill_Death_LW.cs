using System.Collections;

namespace AIScript.Character._15501;

public class Skill_Death_LW : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "15501_White_Out";

	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
