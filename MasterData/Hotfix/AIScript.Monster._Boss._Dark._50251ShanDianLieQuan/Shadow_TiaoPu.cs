using System.Collections;
using TrueSync;

namespace AIScript.Monster._Boss._Dark._50251ShanDianLieQuan;

public class Shadow_TiaoPu : SkillSimpleBase
{
	private readonly string StrongJumpAttack = "StrongJumpAttack";

	private readonly FP JumpTime = 0.35;

	private LogicEntity Targetenemy;

	protected override void OnSkillDisable()
	{
		_actor.DestroySelf();
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginAttack(1, StrongJumpAttack, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(Targetenemy, 5, 30);
		yield return WaitCustomEvent("End");
		PlayEffect("fx_m50251_base_Dark_Atk04_ElectricEnergy");
		CancelAttack();
		GetEnemy();
		yield return WaitCustomEvent("A1");
		StopWaitLookAt();
		Dash();
		BeginLookAt_NotWait(Targetenemy, 2, 180);
		yield return WaitDashFinish();
		StopWaitLookAt();
		DashMove();
		yield return WaitCombo(ComboAttackType.isComboFinish);
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
		BeginDashActorForward(1, GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) / JumpTime, GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true), 0, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}

	private void DashMove()
	{
		BeginDashActorForward(2, 5, 2, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}
}
