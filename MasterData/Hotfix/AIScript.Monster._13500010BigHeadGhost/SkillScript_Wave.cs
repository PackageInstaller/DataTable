using System.Collections;

namespace AIScript.Monster._13500010BigHeadGhost;

public class SkillScript_Wave : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Atk_HuiShou";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(keyIndex, key, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill.Clear();
	}
}
