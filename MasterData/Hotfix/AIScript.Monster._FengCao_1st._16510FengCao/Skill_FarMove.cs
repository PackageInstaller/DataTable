using System.Collections;
using TrueSync;

namespace AIScript.Monster._FengCao_1st._16510FengCao;

public class Skill_FarMove : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private static readonly string StopLookAT_Event = "StopLookAt";

	private static readonly string StartDash_Event = "StartDash";

	private static readonly string StopDash_Event = "StopDash";

	private LogicEntity AttackTarget;

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
		yield return BeginLookAt(AttackTarget, 0.2, 900);
		BeginAttack(startKeyIndex1, startKey);
		Skill_FarMove skill_FarMove = this;
		TSVector2 position = GetPosition();
		FP entityAngle = GetEntityAngle(_actor);
		skill_FarMove.PlayEffect("fx_warning_dash_4x8", 1f, default, position, entityAngle);
		yield return WaitCustomEvent(StopLookAT_Event);
		StopLookAt();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		DoDash();
		yield return WaitDashFinish();
		CancelAttack();
		BeginLookAt_NotWait(AttackTarget, 0.5, 540);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 5, 25, 0, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 2);
	}
}
