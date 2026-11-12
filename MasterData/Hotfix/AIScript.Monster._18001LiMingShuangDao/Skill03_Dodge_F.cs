using System.Collections;
using TrueSync;

namespace AIScript.Monster._18001LiMingShuangDao;

public class Skill03_Dodge_F : SkillSimpleBase
{
	private readonly string Dodge_F = "Skill03_Dodge_F";

	private LogicEntity TargetEnemy;

	private readonly FP DashSpeed = 26;

	protected readonly FP dash_angleLimit = 80;

	protected override IEnumerator DoMainLogic()
	{
		TargetEnemy = GetAttackTarget();
		if (TargetEnemy == null)
		{
			TargetEnemy = GetCurrentPlayer();
		}
		BeginLookAt_NotWait(TargetEnemy, 0.3, 500);
		yield return WaitTime(0.2);
		BeginAttack(1, Dodge_F);
		yield return WaitTime(0.1f);
		FP distanceWithTarget = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: false);
		distanceWithTarget = ((distanceWithTarget >= 12) ? ((FP)12) : distanceWithTarget);
		BeginDashActorForward(1, DashSpeed, distanceWithTarget, dash_angleLimit, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false);
		yield return WaitDashFinish();
		BeginLookAt_NotWait(TargetEnemy, 0.1, 400);
		yield return WaitTime(0.1f);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
