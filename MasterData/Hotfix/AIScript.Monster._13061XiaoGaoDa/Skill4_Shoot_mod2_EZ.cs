using System.Collections;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill4_Shoot_mod2_EZ : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity _target = GetAttackTarget();
		BeginLookAt(_target, 1, 300);
		yield return WaitTime(0.2);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitTime(0.8);
		AimAtTarget(_target, 80);
		yield return WaitTime(1.4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
