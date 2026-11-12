using System.Collections;
using TrueSync;

namespace AIScript.Monster._14021ZhongZhuangLvRen;

public class Skill_NormalAttack : SkillSimpleBase
{
	private static readonly FP _rotateSpeed = 180;

	private static readonly FP _duration = 0.8;

	private static readonly FP _waitSeconds = 0.8;

	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		LogicEntity attackTarget = GetAttackTarget();
		BeginLookAt_NotWait(attackTarget, _duration, _rotateSpeed);
		yield return WaitTime(1.7);
		doDash_A();
		yield return WaitTime(0.5);
		doDash_B();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void doDash_A()
	{
		BeginDashActorForward(1, 1.5, 0.5, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void doDash_B()
	{
		BeginDashActorForward(1, 1.5, 0.5, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
