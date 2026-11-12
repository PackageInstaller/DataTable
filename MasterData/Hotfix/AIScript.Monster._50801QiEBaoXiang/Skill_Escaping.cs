using System.Collections;

namespace AIScript.Monster._50801QiEBaoXiang;

public class Skill_Escaping : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Escape_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private long Emoji;

	protected override void OnSkillDisable()
	{
		StopEffect(Emoji);
	}

	protected override IEnumerator DoMainLogic()
	{
		SetSuperArmorEnable();
		Emoji = PlayEffect("Escape_Emoji");
		BeginAttack(1, Escape_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(8);
		StopEffect(Emoji);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
