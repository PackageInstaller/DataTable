using System.Collections;
using TrueSync;

namespace AIScript.Monster._50101YinYing;

public class Skill_DarkWave_Fan : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected FP rotateSpeed = 180;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack_Combo);
		BeginLookAt_NotWait(GetAttackTarget(), 999, rotateSpeed);
		yield return WaitCustomEvent("StopTurn");
		StopWaitLookAt();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
