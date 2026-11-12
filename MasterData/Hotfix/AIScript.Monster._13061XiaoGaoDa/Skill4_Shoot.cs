using System.Collections;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill4_Shoot : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget();
		BeginLookAt(attackTarget, 1, 400);
		yield return WaitTime(0.5);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitTime(1.4);
		yield return WaitTime(1.4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
