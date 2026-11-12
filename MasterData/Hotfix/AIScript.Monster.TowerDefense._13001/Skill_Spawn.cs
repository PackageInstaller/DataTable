using System.Collections;

namespace AIScript.Monster.TowerDefense._13001;

public class Skill_Spawn : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Birth";

	protected override IEnumerator DoMainLogic()
	{
		_actor.EnableCloseBlock();
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}
}
