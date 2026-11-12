using System.Collections;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill2_Weak_Lv1 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly ComboInputBuffer.ActionKey[] _actionKeys2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitTime(6);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(2, _actionKeys2, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillEnable()
	{
	}
}
