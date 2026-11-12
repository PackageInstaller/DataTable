#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._10001TuBoShu;

public class Skill_eliteSpin_LD : SkillSimpleBase
{
	private static int AttackTimes;

	private readonly int atkTimes = 6;

	private static LogicEntity target;

	private readonly int spinATKIndex;

	private readonly string spinATKKey = "elite_spinATK";

	private readonly FP speed = 4.5;

	private readonly FP angleLimit = 80;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("精英土拨鼠.技能开始");
	}

	protected override void OnSkillDisable()
	{
		AttackTimes = 0;
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			target = GetAttackTarget();
		}
		else
		{
			target = GetCurrentPlayer();
		}
		BeginAttack(spinATKIndex, spinATKKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StartCor(ATKDash());
		yield return WaitCombo(ComboAttackType.isRecoveryBegin);
		StopDash();
		StopLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex == spinATKIndex)
		{
			AttackTimes++;
			NovaLogger.Debug("精英土拨鼠.攻击循环计数" + AttackTimes);
			if (AttackTimes == atkTimes)
			{
				CancelAttack();
			}
		}
	}

	protected IEnumerator ATKDash()
	{
		BeginDashActorForward(10, speed, 99, angleLimit, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		BeginLookAt_NotWait(target, 99, angleLimit);
		yield return null;
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		int num = 8;
		double num2 = (double)num * 0.6;
		if (comboIndex == spinATKIndex && eventName == "beginAttack")
		{
			BeginDashActorForward(10, num, num2, angleLimit, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		}
	}
}
