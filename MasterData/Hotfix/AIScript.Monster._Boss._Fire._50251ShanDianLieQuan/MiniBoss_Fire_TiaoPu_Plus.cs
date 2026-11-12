using System.Collections;
using TrueSync;

namespace AIScript.Monster._Boss._Fire._50251ShanDianLieQuan;

public class MiniBoss_Fire_TiaoPu_Plus : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.C,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] Move = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private LogicEntity Targetenemy;

	private TSVector2 ExplodePosition;

	protected override IEnumerator DoMainLogic()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -15 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 15)
		{
			BeginAttack(1, Attack, flushInputedKeys: true);
			yield return WaitCustomEvent("End");
			CancelAttack();
			GetEnemy();
			yield return WaitCustomEvent("A1");
			Dash();
			BeginLookAt_NotWait(Targetenemy, 0.5, 180);
			yield return WaitDashFinish();
			StopWaitLookAt();
			DashMove();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			ExplodePosition = GetEntityPosition(Targetenemy);
			yield return WaitTime(0.5);
			PlayAreaEffect("Area_50251_MiniBoss_Fire_TiaoPuPlus_GroundExplode", ExplodePosition);
		}
		else
		{
			BeginAttack(1, Move, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			BeginLookAt(Targetenemy, 0.3, 240);
			BeginAttack(2, Attack, flushInputedKeys: true);
			yield return WaitCustomEvent("End");
			CancelAttack();
			GetEnemy();
			yield return WaitCustomEvent("A1");
			Dash();
			BeginLookAt_NotWait(Targetenemy, 0.5, 180);
			yield return WaitDashFinish();
			StopWaitLookAt();
			DashMove();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			ExplodePosition = GetEntityPosition(Targetenemy);
			yield return WaitTime(0.5);
			PlayAreaEffect("Area_50251_MiniBoss_Fire_TiaoPuPlus_GroundExplode", ExplodePosition);
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
		BeginDashActorForward(1, 24, 4, 0, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}

	private void DashMove()
	{
		BeginDashActorForward(2, 5, 2, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}
}
