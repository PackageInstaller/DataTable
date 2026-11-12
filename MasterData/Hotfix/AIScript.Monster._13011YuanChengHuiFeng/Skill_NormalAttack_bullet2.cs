using System.Collections;
using TrueSync;

namespace AIScript.Monster._13011YuanChengHuiFeng;

public class Skill_NormalAttack_bullet2 : SkillSimpleBase
{
	private static readonly FP _rotateSpeed = 40;

	private static readonly FP _duration = 0.8;

	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		LogicEntity attackTarget = GetAttackTarget();
		BeginLookAt_NotWait(attackTarget, _duration, _rotateSpeed);
		yield return WaitTime(0.4);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
