using System.Collections;
using TrueSync;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill_NormalAttack_Empty : SkillSimpleBase
{
	private static readonly FP _rotateSpeed = 240;

	private static readonly FP _duration = 0.3;

	private static readonly FP _waitSeconds = 1.0;

	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity _target = GetAttackTarget();
		BeginLookAt(_target, 1, 400);
		yield return WaitTime(1);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		BeginLookAt_NotWait(_target, _duration, _rotateSpeed);
		yield return WaitTime(_waitSeconds);
		doDash_A();
		yield return WaitTime(0.33);
		doDash_B();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void doDash_A()
	{
		BeginDashActorForward(1, 6, 1.8, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void doDash_B()
	{
		BeginDashActorForward(2, 6, 1.6, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
