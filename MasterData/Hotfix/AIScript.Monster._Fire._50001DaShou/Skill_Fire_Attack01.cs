using System.Collections;

namespace AIScript.Monster._Fire._50001DaShou;

public class Skill_Fire_Attack01 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._0
	};

	private static readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1
	};

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("C1");
		BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("C2");
		CancelAttack();
		yield return WaitFrame(40);
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
