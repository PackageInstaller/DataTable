using System.Collections;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill4_Shoot_Wind : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity _target = GetAttackTarget();
		BeginLookAt_NotWait(_target, 1, 400);
		yield return WaitTime(0.5);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		AimAtTarget(_target, 120);
		yield return WaitTime(1.4);
		CancelAim();
		yield return WaitTime(1.4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
