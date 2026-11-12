using System.Collections;

namespace AIScript.Monster._Wind._50001DaShou;

public class Skill_Wind_Attack01 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1];

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "T1" && CheckTargetIsValid(GetAttackTarget()))
		{
			BeginLookAt_NotWait(GetAttackTarget(), 0.66, 150);
		}
		else if (eventName == "T2")
		{
			StopWaitLookAt();
		}
	}
}
