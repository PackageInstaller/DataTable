using System.Collections;

namespace AIScript.Monster._Wind._50041XiaoFa;

public class Skill_Wind_Attack02 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true);
		yield return WaitCustomEvent("Combo");
		BeginAttack(1, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == custom_Turn && CheckTargetIsValid(GetAttackTarget()))
		{
			WaitLookAt_NoWait(GetAttackTarget(), 5, GetRotSpdInSkill() * 1);
		}
		else if (eventName == custom_StopTurn)
		{
			StopWaitLookAt();
		}
	}
}
