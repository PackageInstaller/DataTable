using System.Collections;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai_V3;

public class Skill04_DashSide : SkillSimpleBase
{
	private static readonly string TurnLeft = "TurnLeft";

	private static readonly string TurnRight = "TurnRight";

	private static readonly FP DashDistance = 5;

	private static readonly FP DashSpeed1 = 20;

	private static readonly FP DashSpeed2 = 8;

	private string Dash_Side;

	private LogicEntity Targetenemy;

	private long IceBuffArea;

	private FP WarningAngle;

	private FP AreaPosition;

	protected override void OnSkillDisable()
	{
		StopAreaEffect(IceBuffArea);
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 45 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 0)
		{
			BeginAttack(1, TurnRight, flushInputedKeys: true, forceInterruptAttack: true);
			yield return BeginLookAtByPos(GetPosition() + RotateTo(GetEntityPosition(Targetenemy) - GetPosition(), -90), 1, 60);
		}
		else if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= -45 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 0)
		{
			BeginAttack(2, TurnLeft, flushInputedKeys: true, forceInterruptAttack: true);
			yield return BeginLookAtByPos(GetPosition() + RotateTo(GetEntityPosition(Targetenemy) - GetPosition(), 90), 1, 60);
		}
		else
		{
			yield return WaitFrame(1);
		}
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 0)
		{
			WarningAngle = 90;
			AreaPosition = -1;
			Dash_Side = "DashSide_Left";
		}
		else
		{
			WarningAngle = -90;
			AreaPosition = 1;
			Dash_Side = "DashSide_Right";
		}
		BeginAttack(3, Dash_Side, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEarlyWarningEffect("fx_warning_dash_7x5", 1f, 0, GetPosition(), GetRotation() + WarningAngle);
		yield return WaitTime(1);
		IceBuffArea = PlayAreaEffect("Area_IceBuff_Dash", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(AreaPosition, 0)));
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopAreaEffect(IceBuffArea);
		yield return WaitTime(1);
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
