using System.Collections;

namespace AIScript.Monster._HardLevel._50101YinYing;

public class HardLevel_Skill_02_02 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1600352851,
		(ComboInputBuffer.ActionKey)1718906696,
		(ComboInputBuffer.ActionKey)1415346281
	};

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true);
		BeginLookAt_NotWait(GetAttackTarget(), 0.8, 250);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
