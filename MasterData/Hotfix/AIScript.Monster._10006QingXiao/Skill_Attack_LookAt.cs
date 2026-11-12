using System.Collections;
using TrueSync;

namespace AIScript.Monster._10006QingXiao;

public class Skill_Attack_LookAt : SkillSimpleBase
{
	private readonly FP _rotateSpeed = 180;

	private readonly FP _duration = 0.8;

	private readonly FP _waitSeconds = 0.8;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		LogicEntity attackTarget = GetAttackTarget();
		BeginLookAt_NotWait(attackTarget, _duration, _rotateSpeed);
		yield return WaitTime(_waitSeconds);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitTime(1.2);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
