using System.Collections;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai_V3;

public class Skill05_DashBack : SkillSimpleBase
{
	private string DashBack = "DashBack";

	private string TurnLeft = "TurnLeft";

	private string TurnRight = "TurnRight";

	private static readonly FP DashDistance = 8;

	private static readonly FP DashSpeed1 = 12;

	private static readonly FP DashSpeed2 = 5;

	private LogicEntity Targetenemy;

	private TSVector2 FaceDirection;

	private long IceBuffArea;

	protected override void OnSkillDisable()
	{
		StopAreaEffect(IceBuffArea);
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		FaceDirection = GetPosition() - GetEntityPosition(Targetenemy);
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 135)
		{
			BeginAttack(1, TurnRight, flushInputedKeys: true, forceInterruptAttack: true);
			yield return BeginLookAtByDir(FaceDirection, 1, 45);
		}
		else
		{
			BeginAttack(2, TurnLeft, flushInputedKeys: true, forceInterruptAttack: true);
			yield return BeginLookAtByDir(FaceDirection, 1, 45);
		}
		BeginAttack(3, DashBack, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Dash");
		IceBuffArea = PlayAreaEffect("Area_IceBuff_Dash", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, -1)));
		Dash1();
		yield return WaitDashFinish();
		CancelAttack();
		Dash2();
		yield return WaitCustomEvent("StopDash");
		StopDash();
		StopAreaEffect(IceBuffArea);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
	}

	private void Dash1()
	{
		BeginDash(1, RotateTo(GetForward(), 180), DashSpeed1, DashDistance * 0.7, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void Dash2()
	{
		BeginDash(1, RotateTo(GetForward(), 180), DashSpeed2, DashDistance * 0.3, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
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
