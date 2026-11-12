using System.Collections;

namespace AIScript.Monster._13500010BigHeadGhost;

public class Skill_Spawn : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Birth";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
