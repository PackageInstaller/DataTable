using System.Collections;

namespace AIScript.Monster._13041MiNieWa;

public class Skill_Death_LD : SkillSimpleBase
{
	private readonly int ActionIndex;

	private readonly string ActionKey = "Death";

	protected override void OnSkillEnable()
	{
		SetUnparalleledEnable();
		SetCloseBlockEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		BeginAttack(ActionIndex, ActionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
