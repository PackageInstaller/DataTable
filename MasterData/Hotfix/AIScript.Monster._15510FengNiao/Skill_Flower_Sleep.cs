using System.Collections;

namespace AIScript.Monster._15510FengNiao;

public class Skill_Flower_Sleep : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Sleep_Combo = new ComboInputBuffer.ActionKey[1];

	protected override IEnumerator DoMainLogic()
	{
		RemoveBuffFromTarget(_actor, 155105320);
		SetLogicTagToggleValue(_actor, "Awaken", value: false);
		SetLogicTagToggleValue(_actor, "ActiveHurt", value: false);
		BeginAttack(1, Sleep_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.5);
		ReplaceAnimationGroup(1);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
	}
}
