using System.Collections;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_Tired : SkillScript_Base
{
	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Tired");
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(Config.loopTime_Tired);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
