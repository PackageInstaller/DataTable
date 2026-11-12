using System.Collections;

namespace AIScript.Monster._10020BanShenCao;

public class Skill_Born : SkillSimpleBase
{
	private static readonly int ActionIndex = 0;

	private static readonly string BornAction = "Born";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(ActionIndex, BornAction);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
