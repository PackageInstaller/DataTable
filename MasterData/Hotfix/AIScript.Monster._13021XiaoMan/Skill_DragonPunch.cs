using System.Collections;
using TrueSync;

namespace AIScript.Monster._13021XiaoMan;

public class Skill_DragonPunch : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Punch_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private long ChargeFX;

	protected override void OnSkillDisable()
	{
		StopWaitLookAt();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Punch_Combo, flushInputedKeys: true);
		ChargeFX = PlayEffect("Skill3_Charge");
		BeginLookAt_NotWait(GetAttackTarget(), 99, 100);
		FP Distance = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.5);
		PlayEffect("Charge", 1f, 1.5, GetPosition());
		StopWaitLookAt();
		yield return WaitTime(0.3);
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			Distance = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		}
		StopEffect(ChargeFX);
		BeginAttack(2, Punch_Combo);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginDashActorForward(1, 60, Distance - 1, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		BeginAttack(3, Punch_Combo);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
