using System.Collections;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa_MiniBoss;

public class Attack02_Temporary : SkillSimpleBase
{
	private static readonly string Dash1 = "Dash";

	private static readonly FP DashSpeed = 50;

	private LogicEntity Targetenemy;

	private FP DashDistance;

	private FP StopDistance;

	protected override void OnSkillEnable()
	{
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			StopDistance = 3;
		}
		else
		{
			StopDistance = -2;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginAttack(1, Dash1, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(Targetenemy, 0.45, 800);
		yield return WaitCustomEvent("warning");
		PlayEarlyWarningEffect("fx_warning_dash_3x8", 0.5f, 0, GetPosition(), GetTSVectToAngle(GetForward(), 0));
		yield return WaitCustomEvent("dash");
		DashDistance = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) + StopDistance;
		if (DashDistance < 2)
		{
			DashDistance = 2;
		}
		Dash();
		yield return WaitDashFinish();
		CancelAttack();
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.15, 1200);
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
		BeginDashActorForward(1, DashSpeed, DashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}
}
