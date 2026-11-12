using System.Collections;

namespace AIScript.Monster._None._50041XiaoFa;

public class Skill_None_Attack01 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1];

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true);
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
