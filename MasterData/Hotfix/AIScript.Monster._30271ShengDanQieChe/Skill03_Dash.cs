using System.Collections;
using TrueSync;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill03_Dash : SkillSimpleBase
{
	private string RunFastWithDamage = "RunFastWithDamage";

	private string Rest = "Rest";

	private static readonly FP DashSpeed1 = 12;

	private static readonly FP DashSpeed2 = 8;

	private static readonly FP WarningTime = 2;

	private FP DashDistance;

	private LogicEntity Targetenemy;

	private long Emoji;

	protected override void OnSkillDisable()
	{
		StopEffect(Emoji);
	}

	protected override IEnumerator DoMainLogic()
	{
		PlayEarlyWarningEffect("fx_warning_dash_4x20_rotation", (float)WarningTime);
		Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_Idle");
		GetEnemy();
		WaitLookAt_NoWait(Targetenemy, WarningTime, 90);
		yield return WaitTime(WarningTime);
		StopEffect(Emoji);
		BeginAttack(1, RunFastWithDamage, flushInputedKeys: true, forceInterruptAttack: true);
		Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_RunFast");
		GetDashDistance();
		Dash1();
		yield return WaitDashFinish();
		Dash2();
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, DashDistance * 0.2 / DashSpeed2, 900 * DashSpeed2 / DashDistance);
		yield return WaitDashFinish();
		StopEffect(Emoji);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetSuperArmorEnable();
		BeginAttack(2, Rest, flushInputedKeys: true, forceInterruptAttack: true);
		Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_Rest");
		yield return WaitTime(3);
		StopEffect(Emoji);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetSuperArmorDisable();
		AddBuffToTarget(_actor, 508010110);
	}

	private void Dash1()
	{
		BeginDashActorForward(1, DashSpeed1, DashDistance * 0.8, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void Dash2()
	{
		BeginDashActorForward(2, DashSpeed2, DashDistance * 0.2, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void GetDashDistance()
	{
		int num = 1;
		int num2 = 30;
		while (num2 > num && !QueryPositionReachable(_actor, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, num2))))
		{
			num2--;
		}
		DashDistance = num2;
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
