using System.Collections;

namespace AIScript.Monster._50011XingXing.Earth;

public class Skill_Attack_R_Soldier : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "TurnAttack_R", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
