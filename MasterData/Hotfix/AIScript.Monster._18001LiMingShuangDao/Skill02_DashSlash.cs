using System.Collections;
using TrueSync;

namespace AIScript.Monster._18001LiMingShuangDao;

public class Skill02_DashSlash : SkillSimpleBase
{
	private readonly string DashSlash = "DashSlash";

	private readonly FP DashSpeed = 7;

	protected readonly FP dash_angleLimit = 100;

	private LogicEntity TargetEnemy;

	private bool breakOff;

	private long fx_play;

	private static readonly string fx_attack = "fx_m18001_loop_skill02_atk01";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		breakOff = true;
		fx_play = 0L;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (breakOff)
		{
			StopEffect(fx_play);
			fx_play = 0L;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginLookAt_NotWait(TargetEnemy, 0.3, 360);
		yield return WaitTime(0.3);
		BeginAttack(1, DashSlash, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.6);
		BeginDashActorForward(1, DashSpeed, 30, dash_angleLimit, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		BeginLookAt_NotWait(TargetEnemy, 2, dash_angleLimit);
		yield return WaitCustomEvent("AttackFx");
		fx_play = PlayEffect(fx_attack);
		yield return WaitTime(0.2f);
		FP tracetime = 1.4;
		while (GetDistanceWithTarget(GetAttackTarget()) >= 2 && tracetime > 0)
		{
			tracetime -= (FP)0.1;
			yield return WaitTime(0.1);
		}
		StopDash();
		CancelAttack();
		StopEffect(fx_play);
		breakOff = false;
		yield return WaitTime(0.3f);
		BeginLookAt_NotWait(TargetEnemy, 0.4f, 400);
		FP fP = 2.5;
		fP = ((GetDistanceWithTarget(calcDistanceWithoutEntityRadius: false) >= 3) ? ((FP)3) : fP);
		BeginDashActorForward(2, fP / 0.6, fP, dash_angleLimit, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		TargetEnemy = GetAttackTarget();
		if (TargetEnemy == null)
		{
			TargetEnemy = GetCurrentPlayer();
		}
	}
}
