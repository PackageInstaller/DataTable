#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._10001TuBoShu;

public class Skill_SpinAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	private static readonly string custom_Dash = "Dash";

	private static readonly string custom_EndDash = "EndDash";

	private int HitCount;

	private int LoopCount;

	protected override IEnumerator DoMainLogic()
	{
		HitCount = TSRandom.Range(1, 4);
		LoopCount = 0;
		NovaLogger.Debug("本次攻击次数：" + HitCount);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex == 1)
		{
			LoopCount++;
			if (LoopCount == HitCount)
			{
				BeginAttack(2, _actionKeys);
			}
		}
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == custom_Turn)
		{
			WaitLookAt_NoWait(GetAttackTarget(), 5, GetRotSpdInSkill());
		}
		else if (eventName == custom_StopTurn)
		{
			StopWaitLookAt();
		}
		if (comboIndex == 1 && eventName == custom_Dash)
		{
			BeginDashActorForward(1, 8, 2, 30, comboWithAttack: true);
		}
		else if (comboIndex == 2 && eventName == custom_EndDash)
		{
			BeginDashActorForward(2, 8, 2, 30, comboWithAttack: true);
		}
	}
}
