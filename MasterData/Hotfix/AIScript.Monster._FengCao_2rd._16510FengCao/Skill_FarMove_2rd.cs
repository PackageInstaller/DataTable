using System.Collections;
using TrueSync;

namespace AIScript.Monster._FengCao_2rd._16510FengCao;

public class Skill_FarMove_2rd : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private static readonly string StopLookAT_Event = "StopLookAt";

	private static readonly string StartDash_Event = "StartDash";

	private static readonly string StopDash_Event = "StopDash";

	private LogicEntity AttackTarget;

	private FP TargetDis;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override void DashFinishByActor(int index)
	{
		base.DashFinishByActor(index);
	}

	protected override IEnumerator DoMainLogic()
	{
		int times = 2;
		while (times > 0 && AttackTarget != null)
		{
			BeginAttack(startKeyIndex1, startKey);
			BeginLookAt_NotWait(AttackTarget, 0.5, 540);
			yield return WaitCustomEvent(StopLookAT_Event);
			StopLookAt();
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			DoDash();
			yield return WaitDashFinish();
			CancelAttack();
			BeginLookAt_NotWait(AttackTarget, 0.5, 540);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			times--;
		}
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 4, 25, 0, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false, 2);
	}
}
