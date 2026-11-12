using System.Collections;

namespace AIScript.Monster._50531DaGuanZi;

public class Skill3_JumpStart : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	private static readonly string StartDash_Event = "DashStop";

	private LogicEntity AttackTarget;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		for (int times = 6; times > 0; times--)
		{
			AttackTarget = GetAttackTarget();
			if (!(AttackTarget != null))
			{
				break;
			}
			BeginLookAt_NotWait(AttackTarget, 0.1, 720);
			yield return WaitTime(0.1);
			DoDash();
			yield return WaitDashFinish();
		}
		StopDash();
		BeginLookAt_NotWait(AttackTarget, 0.3, 720);
		yield return WaitTime(0.5);
		DoDash_B();
		comboAttack.CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 8, 3, 180, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void DoDash_B()
	{
		BeginDashActorForward(1, 10, 5, 360, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
