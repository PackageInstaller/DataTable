using System.Collections;

namespace AIScript.Monster._50251ShanDianLieQuan;

public class Elite_Skill05 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Sprint");
		DoDash();
		BeginLookAt_NotWait(Targetenemy, 5, 360);
		yield return WaitDashFinish();
		yield return WaitFrame(6);
		StopWaitLookAt();
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void DoDash()
	{
		BeginDashActorForward(1, 15, 30, 360, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: true, triggerFriendStop: false);
	}
}
