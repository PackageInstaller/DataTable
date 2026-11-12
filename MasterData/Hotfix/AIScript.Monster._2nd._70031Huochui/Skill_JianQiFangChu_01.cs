using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._2nd._70031Huochui;

public class Skill_JianQiFangChu_01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.I,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] _actionKey2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.G,
		ComboInputBuffer.ActionKey._2
	};

	private static readonly string StopAttack_Event = "StopAttack";

	private static readonly string StartAttack_Event = "StartAttack";

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
		yield return StartCor(Attack());
	}

	protected IEnumerator MoveAttack()
	{
		BeginLookAt_NotWait(AttackTarget, 2, 360);
		BeginAttack(1, _actionKey2, flushInputedKeys: true, forceInterruptAttack: true);
		TSVector2 forward = GetForward();
		TSVector2 Direction = RotateTo(forward, GetRandomValue(-165, -195, isInt: true));
		FP fP = 6;
		FP speed = fP / 0.2;
		Dash Dash = BeginDash(1, Direction, speed, fP, 360, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		for (int i = 0; i < 5; i++)
		{
			Dash._direction = Direction;
			yield return WaitTime(0.01);
		}
		StopDash();
		yield return StartCor(Attack());
	}

	protected IEnumerator Attack()
	{
		BeginLookAt_NotWait(AttackTarget, 8, 160);
		BeginAttack(2, _actionKey1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		for (int i = 0; i < 2; i++)
		{
			yield return WaitCustomEvent(StopAttack_Event);
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
