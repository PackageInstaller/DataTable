using System.Collections;

namespace AIScript.Character._15501;

public class Skill_Spawn_MB : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "15501_Black_Born";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}
}
