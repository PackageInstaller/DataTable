using System.Collections;
using TrueSync;

namespace AIScript.Monster._50531DaGuanZi;

internal class Skill5_Jump_loop : SkillSimpleBase
{
	private static readonly FP DashSpeed = 50;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.K };

	private FP TargetDis;

	private LogicEntity AttackTarget;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		RemoveBuffFromTarget(_actor, 990010030);
		ResetBlockPriority();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget(isUpToDate: true)))
		{
			AttackTarget = GetAttackTarget(isUpToDate: true);
		}
		else
		{
			AttackTarget = GetCurrentPlayer();
		}
		SetBlockPriorityToStatic();
		BeginAttack(1, startKey, flushInputedKeys: true);
		BeginLookAt_NotWait(AttackTarget, 1.8, 360);
		yield return WaitCustomEvent("StopLookAT");
		StopLookAt();
		for (int times = 5; times > 0; times--)
		{
			if (CheckTargetIsValid(GetAttackTarget(isUpToDate: true)))
			{
				AttackTarget = GetAttackTarget(isUpToDate: true);
			}
			else
			{
				AttackTarget = GetCurrentPlayer();
			}
			RemoveBuffFromTarget(_actor, 990010030);
			BeginLookAt_NotWait(AttackTarget, 8, 540);
			TargetDis = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
			yield return WaitCustomEvent("StartDash");
			AddBuffToTarget(_actor, 990010030);
			BeginDashActorForward(1, DashSpeed, TargetDis, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		}
		yield return WaitTime(0.9);
		yield return WaitDashFinish();
		CancelAttack();
		RemoveBuffFromTarget(_actor, 990010030);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
