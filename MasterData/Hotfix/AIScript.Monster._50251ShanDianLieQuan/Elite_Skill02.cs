using System.Collections;

namespace AIScript.Monster._50251ShanDianLieQuan;

public class Elite_Skill02 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
		BeginAttack(1, Attack, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(Targetenemy, 0.2, 240);
		yield return WaitFrame(55);
		CancelAttack();
		yield return WaitCustomEvent("A1");
		Dash();
		BeginLookAt_NotWait(Targetenemy, 2, 180);
		yield return WaitDashFinish();
		StopWaitLookAt();
		DashMove();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Dash()
	{
		BeginDashActorForward(1, 24, 8, 15, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}

	private void DashMove()
	{
		BeginDashActorForward(2, 5, 3, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}
}
