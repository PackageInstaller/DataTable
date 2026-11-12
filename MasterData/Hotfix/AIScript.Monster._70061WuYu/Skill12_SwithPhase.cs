using System.Collections;

namespace AIScript.Monster._70061WuYu;

public class Skill12_SwithPhase : SkillSimpleBase
{
	private const string ComboKey = "Switch";

	public const int RidingAnimGroupIndex = 0;

	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, "CanUseBroomDodge", value: false);
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(_actor, "CanUseBroomDodge", value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Switch", flushInputedKeys: true, forceInterruptAttack: true);
		ReplaceAnimationGroup();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
