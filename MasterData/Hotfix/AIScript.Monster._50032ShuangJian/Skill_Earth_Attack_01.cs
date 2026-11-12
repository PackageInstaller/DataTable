using System.Collections;

namespace AIScript.Monster._50032ShuangJian;

public class Skill_Earth_Attack_01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] EarthAttack01 = new ComboInputBuffer.ActionKey[1];

	private static readonly string TurnToTargetStart = "Start";

	private static readonly string TurnToTargetEnd = "End";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, EarthAttack01, flushInputedKeys: true, forceInterruptAttack: true);
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
