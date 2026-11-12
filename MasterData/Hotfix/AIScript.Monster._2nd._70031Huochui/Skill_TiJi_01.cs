using System.Collections;

namespace AIScript.Monster._2nd._70031Huochui;

public class Skill_TiJi_01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.N,
		ComboInputBuffer.ActionKey._1
	};

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAt_NotWait(AttackTarget, 1, 360);
		yield return WaitTime(1);
		StopWaitLookAt();
		BeginAttack(1, _actionKey1, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(AttackTarget, 1, 200);
		yield return WaitTime(1);
		StopWaitLookAt();
		yield return WaitTime(0.7);
		BeginLookAt_NotWait(AttackTarget, 2.3, 200);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
