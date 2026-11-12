using System.Collections;

namespace AIScript.Monster._50032ShuangJian;

public class Skill_Wind_Attack_01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] BlackAttack01 = new ComboInputBuffer.ActionKey[1];

	private static readonly string TurnToTargetStart = "Start";

	private static readonly string TurnToTargetEnd = "End";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, BlackAttack01, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == TurnToTargetStart)
		{
			BeginLookAt_NotWait(GetCurrentPlayer(), 0.25, 360, 0);
		}
		else if (eventName == TurnToTargetEnd)
		{
			StopWaitLookAt();
		}
	}
}
