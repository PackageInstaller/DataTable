#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50081DaShiLaiMu;

public class Skill_Assault_LD : SkillSimpleBase
{
	private static readonly string _AssaultCombo_L = "Assault_Long";

	private static readonly int AssaultKey_L = 1;

	private static readonly string _AssaultCombo_S = "Assault_Short";

	private static readonly int AssaultKey_S = 2;

	private static readonly string _DiffusionCombo = "DiffusionBubble";

	private static readonly int DiffusionComboIndex = 4;

	private static readonly FP THOfLongDist = 8;

	private static readonly FP THOfShortDist = 4;

	private static readonly FP Speed_L = 6;

	private static readonly FP Distance_L = 18;

	private static readonly FP Distance_S = 12;

	private static readonly FP Speed_S = 6;

	private static readonly FP F2FDist = 3;

	private static readonly FP THOfDist = 9;

	private static readonly FP AngleLimit = 180;

	private static LogicEntity Target;

	private static FP StopLoop;

	private static readonly int DashIndex = 5;

	private static FP DashSpeed;

	private static FP DashDistance;

	private static readonly bool ActionSwitch = true;

	private static readonly bool AngleSwitch = true;

	private static readonly bool NotChangeForward = true;

	private static readonly FP TurnTime = 99;

	private static FP RelativeDist;

	protected override IEnumerator DoMainLogic()
	{
		Target = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(Target))
		{
			InterruptSkill();
			yield break;
		}
		RelativeDist = Distance(GetPosition(), GetEntityPosition(Target));
		if (RelativeDist >= THOfLongDist)
		{
			BeginAttack(AssaultKey_L, _AssaultCombo_L, flushInputedKeys: false, forceInterruptAttack: true);
			DashSpeed = Speed_L;
			DashDistance = Distance_L;
			StopLoop = Distance_L / Speed_L * 0.9;
		}
		else if (RelativeDist < THOfShortDist && RelativeDist >= F2FDist)
		{
			BeginAttack(AssaultKey_S, _AssaultCombo_S, flushInputedKeys: false, forceInterruptAttack: true);
			DashSpeed = Speed_S;
			DashDistance = Distance_S;
			StopLoop = Distance_S / Speed_S * 0.8;
		}
		else
		{
			BeginAttack(AssaultKey_S, _AssaultCombo_S, flushInputedKeys: false, forceInterruptAttack: true);
			DashSpeed = 2;
			DashDistance = 1.8;
			StopLoop = DashDistance / DashSpeed;
		}
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		Target = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(Target))
		{
			Target = _actor;
		}
		BeginDashActorForward(DashIndex, DashSpeed, DashDistance, AngleLimit, ActionSwitch, AngleSwitch, NotChangeForward, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		WaitLookAt_NoWait(Target, TurnTime, AngleLimit);
		yield return WaitTime(StopLoop);
		CancelAttack();
		yield return WaitDashFinish();
		StopWaitLookAt();
		yield return WaitDashFinish();
		Target = GetAttackTarget();
		if (Target == null)
		{
			Target = _actor;
		}
		RelativeDist = Distance(GetPosition(), GetEntityPosition(Target));
		if (RelativeDist >= THOfDist)
		{
			BeginAttack(DiffusionComboIndex, _DiffusionCombo, flushInputedKeys: false, forceInterruptAttack: true);
			NovaLogger.Debug("释放扩散攻击");
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		NovaLogger.Debug("技能结束");
	}
}
