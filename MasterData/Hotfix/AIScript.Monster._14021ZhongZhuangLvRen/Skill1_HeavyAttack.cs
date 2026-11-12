using System.Collections;

namespace AIScript.Monster._14021ZhongZhuangLvRen;

public class Skill1_HeavyAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		LogicEntity _target = GetAttackTarget();
		BeginLookAt_NotWait(_target, 0.8, 180);
		yield return WaitTime(1.9);
		doDash_A();
		yield return WaitTime(0.7);
		BeginLookAt_NotWait(_target, 0.3, 120);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void doDash_A()
	{
		BeginDashActorForward(1, 3.3, 2, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
