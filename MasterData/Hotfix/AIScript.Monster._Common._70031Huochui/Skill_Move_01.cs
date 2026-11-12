using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._Common._70031Huochui;

public class Skill_Move_01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.G,
		ComboInputBuffer.ActionKey._1
	};

	private LogicEntity AttackTarget;

	private TSVector2 Direction;

	private static readonly string Dash_Event = "Dash";

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
		BeginLookAt_NotWait(AttackTarget, 3, 540);
		BeginAttack(1, _actionKey1, flushInputedKeys: true, forceInterruptAttack: true);
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
		FP fP = 6;
		FP speed = fP / 0.3;
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
	}
}
