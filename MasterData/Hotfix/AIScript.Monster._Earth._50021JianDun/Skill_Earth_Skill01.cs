using System.Collections;

namespace AIScript.Monster._Earth._50021JianDun;

public class Skill_Earth_Skill01 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true);
		yield return WaitCustomEvent("D1");
		DoDash();
		yield return WaitCustomEvent("D2");
		StopDash();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void DoDash()
	{
		BeginDashActorForward(1, 10, 4, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "T1")
		{
			BeginLookAt_NotWait(GetCurrentPlayer(), 0.25, 360, 0);
		}
		else if (eventName == "T2")
		{
			StopWaitLookAt();
		}
	}
}
