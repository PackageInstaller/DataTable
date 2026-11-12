using System.Collections;

namespace AIScript.Monster._1st._70031Huochui;

public class Attack_QingJianGongJi : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string StopTurn_Event = "StopTurn";

	private static readonly string StartTurn_Event = "StartTurn";

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
		BeginLookAt_NotWait(AttackTarget, 0.2, 360);
		yield return WaitTime(0.2);
		StopWaitLookAt();
		BeginAttack(1, _actionKey1);
		yield return WaitCustomEvent(StartTurn_Event);
		BeginLookAt_NotWait(AttackTarget, 2, 360);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
