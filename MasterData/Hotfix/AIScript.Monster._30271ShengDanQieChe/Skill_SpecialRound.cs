using System.Collections;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill_SpecialRound : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Rest_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private long Emoji;

	protected override void OnSkillDisable()
	{
		StopEffect(Emoji);
	}

	protected override IEnumerator DoMainLogic()
	{
		SetSuperArmorEnable();
		BeginAttack(1, Rest_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		Emoji = PlayEffect("Rest_Emoji");
		yield return WaitTime(6.5);
		StopEffect(Emoji);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetSuperArmorDisable();
		AddBuffToTarget(_actor, 508010110);
	}
}
