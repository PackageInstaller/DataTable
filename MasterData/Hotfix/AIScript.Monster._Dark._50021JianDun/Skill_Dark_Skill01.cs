using System.Collections;

namespace AIScript.Monster._Dark._50021JianDun;

public class Skill_Dark_Skill01 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		BeginAttack(1, Attack, flushInputedKeys: true);
		WaitLookAt_NoWait(logicEntity, 5, GetRotSpdInSkill() * 1);
		yield return WaitCustomEvent("TurnOver");
		StopWaitLookAt();
		yield return WaitCustomEvent("StartDash");
		BeginDashActorForward(1, 20, 4, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		CancelAttack();
		yield return WaitCustomEvent("StartDash2");
		BeginDashActorForward(2, 20, 1, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
