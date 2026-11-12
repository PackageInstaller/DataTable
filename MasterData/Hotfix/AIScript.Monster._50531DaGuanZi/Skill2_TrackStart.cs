using System.Collections;

namespace AIScript.Monster._50531DaGuanZi;

public class Skill2_TrackStart : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	private LogicEntity AttackTarget;

	protected override IEnumerator DoMainLogic()
	{
		AttackTarget = GetAttackTarget();
		if (AttackTarget == null)
		{
			yield break;
		}
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		BeginLookAt_NotWait(AttackTarget, 1.33, 540);
		yield return WaitTime(1.33);
		StopLookAt();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		for (int times = 40; times > 0; times--)
		{
			AttackTarget = GetAttackTarget();
			if (!(AttackTarget != null))
			{
				break;
			}
			BeginLookAt_NotWait(AttackTarget, 0.1, 90);
			yield return WaitTime(0.1);
			DoDash();
		}
		yield return WaitDashFinish();
		comboAttack.CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 8, 8, 30, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}
}
