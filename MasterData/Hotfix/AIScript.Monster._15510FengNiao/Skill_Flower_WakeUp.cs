using System.Collections;

namespace AIScript.Monster._15510FengNiao;

public class Skill_Flower_WakeUp : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] WakeUp_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		AddBuffToTarget(_actor, 155105320);
		BeginAttack(1, WakeUp_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return null;
		ReplaceAnimationGroup();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetLogicTagToggleValue(_actor, "Awaken", value: true);
		SetLogicTagToggleValue(_actor, "ActiveHurt", value: true);
	}
}
