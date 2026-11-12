using System.Collections;

namespace AIScript.Character._16101.Summoned.JuDian;

public class Skill_Spawn_JuDian : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Main_Brith";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(keyIndex, key, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill?.Clear();
	}
}
