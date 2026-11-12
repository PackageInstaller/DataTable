using System.Collections;

namespace AIScript.Monster._Light._50021JianDun;

public class Skill_Light_Skill01 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true);
		yield return WaitCustomEvent("C1");
		CancelAttack();
		DoDash();
		yield return WaitCustomEvent("D1");
		StopDash();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "T1")
		{
			BeginLookAt_NotWait(GetCurrentPlayer(), 0.3, 360, 0);
		}
		else if (eventName == "T2")
		{
			StopWaitLookAt();
		}
	}

	protected void DoDash()
	{
		BeginDashActorForward(1, 10, 2, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}
}
