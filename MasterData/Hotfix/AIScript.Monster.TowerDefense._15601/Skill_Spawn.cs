using System.Collections;

namespace AIScript.Monster.TowerDefense._15601;

public class Skill_Spawn : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Birth";

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
