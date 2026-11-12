using System.Collections;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Born_IceMaker : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Born = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.U };

	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		yield return null;
		SetHideModelDisable();
		BeginAttack(1, Born, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
