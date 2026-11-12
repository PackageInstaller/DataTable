#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50081DaShiLaiMu;

public class Skill_Assault_Long_LD : SkillSimpleBase
{
	private int branch;

	private const int diffTag1 = 500810000;

	private const int diffTag2 = 500810001;

	private const int diffTag3 = 500810002;

	private static readonly string _AssaultCombo_L = "Assault_Long";

	private static readonly int AssaultKey_L = 1;

	private FP DashSpeed;

	private FP DashDistance = 99;

	private static readonly FP AngleLimit = 360;

	private static LogicEntity Target;

	private static FP StopLoop;

	private int times;

	private static readonly int DashIndex = 5;

	private static readonly bool ActionSwitch = true;

	private static readonly bool AngleSwitch = true;

	private readonly bool NotChangeForward = true;

	private static readonly FP TurnTime = 99;

	private static FP RelativeDist;

	protected override IEnumerator DoMainLogic()
	{
		List<BuffEntity> buffFromTarget = GetBuffFromTarget(_actor, 0, 500810000);
		if (buffFromTarget.Count != 0)
		{
			switch (buffFromTarget.get_Item(0).buffConfig.Id)
			{
			case 500810000:
				branch = 0;
				break;
			case 500810001:
				branch = 1;
				break;
			case 500810002:
				branch = 2;
				break;
			default:
				branch = 2;
				break;
			}
		}
		else
		{
			branch = 2;
		}
		switch (branch)
		{
		case 0:
			DashSpeed = 15;
			times = 2;
			break;
		case 1:
			DashSpeed = 18;
			times = 2;
			break;
		case 2:
			DashSpeed = 20;
			times = 3;
			break;
		default:
			DashSpeed = 20;
			times = 3;
			break;
		}
		Target = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(Target))
		{
			Target = GetCurrentPlayer();
		}
		BeginAttack(AssaultKey_L, _AssaultCombo_L, flushInputedKeys: false, forceInterruptAttack: true);
		StopLoop = DashDistance / DashSpeed * 0.9;
		FP clampValue = 3;
		DashSpeed = TSMath.Clamp(DashSpeed, 9, 1000);
		clampValue = TSMath.Min(clampValue, 7);
		TSVector2 targetPOS = GetEntityPositionObsoleted(GetCurrentPlayer());
		targetPOS.x = TSMath.Clamp(targetPOS.x, -clampValue, clampValue);
		targetPOS.y = TSMath.Clamp(targetPOS.y, -clampValue, clampValue);
		Skill_Assault_Long_LD skill_Assault_Long_LD = this;
		TSVector2 position = GetPosition();
		FP tSVectToAngle = GetTSVectToAngle(targetPOS - GetPosition(), 0);
		skill_Assault_Long_LD.PlayEffect("fx_warning_dash_7_6x25", 1f, default, position, tSVectToAngle);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		SetCloseBlockEnable();
		for (int i = 0; i < times; i++)
		{
			BeginDash(DashIndex, targetPOS - GetPosition(), DashSpeed, DashDistance * 2, AngleLimit, ActionSwitch, AngleSwitch, NotChangeForward, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 0.3);
			yield return WaitDashFinish();
			clampValue += (FP)1;
			DashSpeed *= (FP)0.6;
			DashSpeed = TSMath.Clamp(DashSpeed, 9, 1000);
			clampValue = TSMath.Clamp(clampValue, clampValue, 7);
			targetPOS = GetEntityPositionObsoleted(GetCurrentPlayer());
			targetPOS.x = TSMath.Clamp(targetPOS.x, -clampValue, clampValue);
			targetPOS.y = TSMath.Clamp(targetPOS.y, -clampValue, clampValue);
		}
		CancelAttack();
		SetCloseBlockDisable();
		WaitLookAt_NoWait(Target, 0.1, 999);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		NovaLogger.Debug("技能结束");
	}
}
