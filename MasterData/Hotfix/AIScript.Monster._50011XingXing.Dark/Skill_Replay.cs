#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Dark;

public class Skill_Replay : SkillScript_Base
{
	private TSVector2 dashForward;

	private bool release;

	private LogicEntity target;

	private readonly List<LogicEntity> ClearActor = new List<LogicEntity>();

	private readonly int DashIndex = 2;

	private CoroutineNode StartCheck;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("猩猩暗.召唤.开始");
		SetUnparalleledEnable();
		SetImmuneControlEnable();
		SetLogicTagToggleValue(_actor, "DropAttackSwitch", value: false);
		release = false;
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("猩猩暗.召唤.结束");
		ClearActor.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		for (int i = 0; i < 11; i++)
		{
			NovaLogger.Debug("猩猩暗.召唤.更新");
			release = GetLogicTagToggleValue(_actor, "release");
			if (release || i == 10)
			{
				yield return StartCor(Dash());
				yield return StartCor(ClearSelf());
			}
			yield return WaitTime(0.1);
		}
		yield return StartCor(ClearSelf());
	}

	protected IEnumerator Dash()
	{
		target = GetTarget();
		_ = (FP)1.2;
		int DashSpeed = 60;
		BeginAttack(SkillScript_Base.DashChargeIndex, SkillScript_Base.DashChargeJumpKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return StartCor(WarningFxGround());
		CancelAttack();
		SetCloseBlockEnable();
		BeginAttack(SkillScript_Base.DashATKIndex, SkillScript_Base.DashATKJumpKey, flushInputedKeys: true, forceInterruptAttack: true);
		dashForward = TransLocalPosToWorldPos(GetPosition(), dashForward, TSVector2.up);
		BeginLookAtByPos_NotWait(dashForward, 0, 900);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StopLookAt();
		BeginDash(DashIndex, GetForward(), DashSpeed, 999, default, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		SetCloseBlockDisable();
		CancelAttack();
		StopCor(StartCheck);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator CheckObstacle()
	{
		for (int i = 0; i < 100; i++)
		{
			if (!QueryPositionReachable(_actor, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 4))))
			{
				NovaLogger.Debug("猩猩检测碰撞，停止冲锋");
				CancelAttack();
				yield return WaitTime(0.1);
				StopDash();
				break;
			}
			NovaLogger.Debug("猩猩持续检测");
			yield return WaitTime(0.05);
		}
	}

	protected IEnumerator ClearSelf()
	{
		PlayEffect("fx_common_base_die", 2f, default, GetPosition());
		yield return WaitTime(1);
		ClearActor.Add(_actor);
		ClearActors(ClearActor);
	}

	private IEnumerator WarningFxGround()
	{
		target = GetTarget();
		yield return WaitTime(0.3);
		string fxAlias = "fx_warning_dash_3x23";
		dashForward = GetEntityPositionObsoleted(target) - GetPosition();
		FP tSVectToAngle = GetTSVectToAngle(dashForward, 0);
		PlayEffect(fxAlias, 1f, default, GetPosition(), tSVectToAngle);
		yield return WaitTime(1);
	}
}
