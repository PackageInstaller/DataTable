#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Earth;

public class Skill_Dash_LD : SkillScript_Base
{
	private TSVector2 targetPOS;

	private int aiType;

	private LogicEntity target;

	private TSVector2 dashForward;

	private static readonly string WarningAreaFx = "WarningArea";

	private List<long> _ATKLFx = new List<long>();

	private readonly int DashIndex = 2;

	private CoroutineNode StartCheck;

	protected override void OnSkillEnable()
	{
		_ATKLFx.Clear();
		aiType = GetAiType();
	}

	protected override void OnSkillDisable()
	{
		StopCor(StartCheck);
		if (_ATKLFx.Count > 0)
		{
			for (int i = 0; i < _ATKLFx.Count; i++)
			{
				StopEffect(_ATKLFx.get_Item(i));
			}
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		IEnumerator CheckCor = CheckObstacle();
		_ = (FP)1.2;
		int DashSpeed = 60;
		BeginAttack(SkillScript_Base.DashChargeIndex, SkillScript_Base.DashChargeJumpKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return StartCor(ElementAttack());
		yield return WaitTime(1.3);
		CancelAttack();
		SetCloseBlockEnable();
		BeginAttack(SkillScript_Base.DashATKIndex, SkillScript_Base.DashATKJumpKey, flushInputedKeys: true, forceInterruptAttack: true);
		target = GetTarget();
		targetPOS = GetEntityPositionObsoleted(target);
		BeginLookAtByPos_NotWait(targetPOS, 0.3, 600);
		StartCor(WarningFxGround());
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginDash(DashIndex, GetForward(), DashSpeed, 999, default, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		StartCheck = StartCor(CheckCor);
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

	private IEnumerator ElementAttack()
	{
		switch (aiType)
		{
		case 0:
			NovaLogger.Debug("猩猩土.冲锋.元素攻击进入简单判断");
			break;
		case 1:
			UpdateEffectTag();
			break;
		default:
			NovaLogger.Debug("猩猩土.冲锋.获取AI类型错误,默认简单");
			break;
		}
		yield break;
	}

	private IEnumerator WarningFxGround()
	{
		yield return WaitTime(0.3);
		string fxAlias = "fx_warning_dash_3x23";
		dashForward = targetPOS - GetPosition();
		FP tSVectToAngle = GetTSVectToAngle(dashForward, 0);
		PlayEffect(fxAlias, 1f, default, GetPosition(), tSVectToAngle);
		yield return WaitTime(1);
	}
}
