using System.Collections;

namespace AIScript.Monster._Boss._Fire._50251ShanDianLieQuan;

public class MiniBoss_Fire_TiaoPu : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.C,
		ComboInputBuffer.ActionKey._0
	};

	private readonly ComboInputBuffer.ActionKey[] Move = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -15 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 15)
		{
			BeginAttack(1, Attack, flushInputedKeys: true);
			yield return WaitCustomEvent("End");
			CancelAttack();
			yield return WaitCustomEvent("A1");
			Dash();
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 2, 180);
			yield return WaitDashFinish();
			StopWaitLookAt();
			DashMove();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginAttack(1, Move, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			BeginLookAt(Targetenemy, 0.3, 240);
			BeginAttack(2, Attack, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("End");
			CancelAttack();
			yield return WaitCustomEvent("A1");
			Dash();
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 2, 180);
			yield return WaitDashFinish();
			StopWaitLookAt();
			DashMove();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	private void Dash()
	{
		BeginDashActorForward(1, 24, 8, 0, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}

	private void DashMove()
	{
		BeginDashActorForward(2, 5, 3, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}
}
