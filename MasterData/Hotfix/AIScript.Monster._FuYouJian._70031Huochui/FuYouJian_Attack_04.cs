using System.Collections;

namespace AIScript.Monster._FuYouJian._70031Huochui;

public class FuYouJian_Attack_04 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] _actionKey2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.Z,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string KillActors_Event = "KillActors";

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget();
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAt_NotWait(AttackTarget, 0.3, 400);
		yield return WaitTime(0.3);
		BeginAttack(1, _actionKey1);
		BeginLookAt_NotWait(AttackTarget, 2, 60);
		yield return WaitTime(1.4f);
		StopLookAt();
		yield return WaitTime(0.2f);
		yield return WaitTime(8);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		StopDash();
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 4, 12, 90, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
