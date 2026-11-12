using System.Collections;
using TrueSync;

namespace AIScript.Monster._18001LiMingShuangDao;

public class Skill03_Dodge_B : SkillSimpleBase
{
	private readonly string Dodge_B = "Skill03_Dodge_B";

	private LogicEntity TargetEnemy;

	private readonly FP DashSpeed = 24;

	protected readonly FP dash_angleLimit = 80;

	private FP dashdis = 5f;

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		if (TargetEnemy != null)
		{
			BeginLookAt_NotWait(TargetEnemy, 0.2, 500);
		}
		yield return WaitTime(0.1);
		BeginAttack(1, Dodge_B);
		yield return WaitTime(0.1f);
		TSVector2 direction = GetPosition() - GetEntityPosition(TargetEnemy);
		BeginDash(1, direction, DashSpeed, dashdis, dash_angleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		yield return WaitDashFinish();
		BeginLookAt_NotWait(TargetEnemy, 0.1, 400);
		yield return WaitTime(0.1f);
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
