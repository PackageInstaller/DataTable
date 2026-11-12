using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._2nd._70031Huochui;

public class Skill_XuLiZhanJi_01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.M,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] _actionKey2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.G,
		ComboInputBuffer.ActionKey._1
	};

	private TSVector2 Direction;

	private static readonly string StopAttack_Event = "StopAttack";

	private static readonly string StopTurn_Event = "StopTurn";

	private static readonly string StartLookAt_Event = "StartLookAt";

	private static readonly string CameraUp_Event = "CameraUp";

	private static readonly string CameraDown_Event = "CameraDown";

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 8)
		{
			yield return StartCor(MoveAttack());
		}
		else
		{
			yield return StartCor(Attack());
		}
	}

	protected IEnumerator MoveAttack()
	{
		BeginLookAt_NotWait(AttackTarget, 3, 540);
		BeginAttack(1, _actionKey2, flushInputedKeys: true, forceInterruptAttack: true);
		TSVector2 forward = GetForward();
		int num = TSRandom.Range(0, 100);
		int num2 = 50;
		if (num < num2)
		{
			Direction = RotateTo(forward, GetRandomValue(40, 70, isInt: true));
		}
		else
		{
			Direction = RotateTo(forward, GetRandomValue(-40, -70, isInt: true));
		}
		FP fP = 10;
		FP speed = fP / 0.5;
		Dash Dash = BeginDash(1, Direction, speed, fP, 540, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		for (int i = 0; i < 5; i++)
		{
			Dash._direction = Direction;
			yield return WaitTime(0.02);
		}
		StopDash();
		TSVector2 forward2 = GetForward();
		TSVector2 direction = RotateTo(forward2, 0);
		FP fP2 = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) - 0.3;
		FP speed2 = fP2 / 0.3;
		BeginDash(1, direction, speed2, fP2, 540, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopDash();
		yield return StartCor(Attack());
	}

	protected IEnumerator Attack()
	{
		BeginLookAt_NotWait(AttackTarget, 1, 360);
		yield return WaitTime(1);
		StopLookAt();
		BeginAttack(1, _actionKey1, flushInputedKeys: true);
		yield return WaitTime(1.5);
		BeginLookAt_NotWait(AttackTarget, 1, 360);
		yield return WaitTime(0.5);
		StopLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		SwitchCameraSetting(active: false, "Camera_XuLiZhanJi");
	}
}
