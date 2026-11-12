using System.Collections;

namespace AIScript.Monster._Dark._HardLevel._50020ShaYuFaShi;

public class HardLevel_Dark_Skill_01 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1];

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true);
		BeginLookAt_NotWait(GetAttackTarget(), 1.2, 360);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
