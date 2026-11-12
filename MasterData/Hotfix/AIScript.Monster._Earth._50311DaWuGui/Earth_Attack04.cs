using System.Collections;

namespace AIScript.Monster._Earth._50311DaWuGui;

public class Earth_Attack04 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Atk = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Atk, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Start");
		ChargeNoAngle();
		yield return WaitCustomEvent("Loop");
		ChargeWithAngle();
		yield return WaitDashFinish();
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void ChargeNoAngle()
	{
		BeginDashActorForward(1, 8, 4, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.5);
	}

	protected void ChargeWithAngle()
	{
		if (GetBuffNum(_actor, 503110002) >= 1)
		{
			BeginLookAt_NotWait(GetCurrentPlayer(), 4, 90);
		}
		else
		{
			BeginLookAt_NotWait(GetCurrentPlayer(), 4, 75);
		}
		BeginDashActorForward(1, 10, 40, 3600, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
