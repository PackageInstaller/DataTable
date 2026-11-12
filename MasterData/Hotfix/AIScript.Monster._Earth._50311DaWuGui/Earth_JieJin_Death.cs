using System.Collections;

namespace AIScript.Monster._Earth._50311DaWuGui;

public class Earth_JieJin_Death : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.J };

	protected override IEnumerator DoMainLogic()
	{
		SetCloseBlockEnable();
		SetHideModelEnable();
		SendDeclareDeadEvent();
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
