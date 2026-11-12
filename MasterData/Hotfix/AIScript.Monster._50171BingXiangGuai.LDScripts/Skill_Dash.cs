#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai.LDScripts;

public class Skill_Dash : SkillBase
{
	private enum E_BrakeType
	{
		Normal,
		SlightWeakness,
		SeverelyWeak
	}

	private bool haveDone;

	private readonly string hittedFx = "fx_50171BingXiangGuai_hit_Nattack";

	protected override void OnSkillEnable()
	{
		haveDone = false;
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		yield return BeginLookAt(target, 1, 180);
		BeginAttack(dashIndex, dashKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		FP speed = 0;
		_ = (FP)10;
		FP updateInterval = 0.03;
		E_BrakeType brakeType = E_BrakeType.SlightWeakness;
		bool dashBranch = false;
		FP dashDuration;
		FP maxSpeed;
		if (Distance(GetPosition(), GetEntityPositionObsoleted(target)) <= 6)
		{
			dashDuration = 0.7;
			maxSpeed = 23;
			dashBranch = true;
		}
		else
		{
			dashDuration = 1;
			maxSpeed = 25;
		}
		SetCloseBlockEnable();
		for (int i = 0; i < (int)(long)(dashDuration / updateInterval); i++)
		{
			if (haveDone)
			{
				break;
			}
			if (i == (int)(long)(dashDuration / updateInterval / 2))
			{
				brakeType = E_BrakeType.SeverelyWeak;
			}
			else if (i == (int)(long)(dashDuration / updateInterval - 1))
			{
				brakeType = E_BrakeType.Normal;
			}
			BeginDashActorForward(dashDMGIndex, speed, 99, 2, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitTime(updateInterval);
			StopDash();
			StopLookAt();
			speed = TSMath.Clamp(speed + 60 * updateInterval, 0, maxSpeed);
			if (!dashBranch)
			{
				BeginLookAt_NotWait(target, updateInterval, 80);
			}
		}
		StopDash();
		StopLookAt();
		SetCloseBlockDisable();
		CancelAttack();
		switch (brakeType)
		{
		case E_BrakeType.Normal:
			yield return WaitCombo(ComboAttackType.isComboFinish);
			break;
		case E_BrakeType.SlightWeakness:
			BeginAttack(slightWeaknessIndex, slightWeaknessKey, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			yield return WaitTime(1.5);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			break;
		case E_BrakeType.SeverelyWeak:
			BeginRotateAngle(90, 900);
			BeginAttack(dashSlide02Index, dashSlide02Key, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			break;
		default:
			NovaLogger.Debug("冰箱怪.刹车类型的SwitchCase有误");
			break;
		}
	}

	private IEnumerator Damage()
	{
		for (int i = 0; i < 10000; i++)
		{
			RectangleDamage(TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 3.5)), 3, 3, GetRotation(), 50171031, hittedFx);
			yield return WaitTime(0.05);
		}
	}
}
