using System.Collections;
using TrueSync;

namespace AIScript.Monster._Hot._70031Huochui;

public class Skill_JuJianLianJi_Hot : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.O,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string StartTurn_Event = "StartTurn";

	private static readonly string EndPostRock_Event = "EndPostRock";

	private static readonly string StartDash_Event = "StartDash";

	private LogicEntity AttackTarget;

	private static readonly FP DashTime = 0.3;

	private FP TargetDis;

	private readonly ComboInputBuffer.ActionKey[] _actionKey2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string StopTurn_Event = "StopTurn";

	private readonly ComboInputBuffer.ActionKey[] _actionKey3 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.N,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] _actionKey4 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.O,
		ComboInputBuffer.ActionKey._2
	};

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
		BeginLookAt_NotWait(AttackTarget, 8, 360);
		BeginAttack(1, _actionKey1, flushInputedKeys: true);
		yield return WaitCustomEvent(StartDash_Event);
		StopLookAt();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		TargetDis = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) + 5;
		SetCloseBlockEnable();
		BeginDashActorForward(1, TargetDis / DashTime, TargetDis, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		CancelAttack();
		SetCloseBlockDisable();
		yield return WaitCustomEvent(StartTurn_Event);
		BeginLookAt_NotWait(AttackTarget, 8, 360);
		yield return WaitCustomEvent(EndPostRock_Event);
		StopWaitLookAt();
		BeginLookAt_NotWait(AttackTarget, 0.1, 720);
		yield return WaitTime(0.1);
		StopWaitLookAt();
		BeginAttack(2, _actionKey2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(StopTurn_Event);
		yield return WaitCustomEvent(StartTurn_Event);
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= 6.5)
		{
			BeginAttack(3, _actionKey4, flushInputedKeys: true, forceInterruptAttack: true);
			BeginLookAt_NotWait(AttackTarget, 2, 540);
			yield return WaitFrame(15);
			StopLookAt();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield break;
		}
		BeginLookAt_NotWait(AttackTarget, 1, 360);
		yield return WaitTime(1);
		StopWaitLookAt();
		BeginAttack(4, _actionKey3, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(AttackTarget, 1, 160);
		yield return WaitTime(1);
		StopWaitLookAt();
		yield return WaitTime(0.7);
		BeginLookAt_NotWait(AttackTarget, 2.3, 160);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		SetCloseBlockDisable();
	}
}
