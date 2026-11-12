using System.Collections;

namespace AIScript.Monster._15001ZhongYeZaBing;

public class Skill_SpecialSpawn : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(2);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
