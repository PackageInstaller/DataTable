using System.Collections;

namespace AIScript.Monster._70021MaoYan;

public class Skill_Death : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		SetUnparalleledEnable();
		SetSearchedImmunityEnable();
		SetCloseBlockEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		int keyIndex = 0;
		string actionKey = "Death";
		BeginAttack(keyIndex, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
