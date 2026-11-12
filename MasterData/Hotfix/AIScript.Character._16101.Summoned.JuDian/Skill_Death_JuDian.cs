using System.Collections;

namespace AIScript.Character._16101.Summoned.JuDian;

public class Skill_Death_JuDian : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Main_Dead";

	protected override IEnumerator DoMainLogic()
	{
		SetCloseBlockEnable();
		_actor.PlayDeathAnim();
		BeginAttack(keyIndex, key, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill?.Clear();
	}
}
