using System.Collections;

namespace AIScript.Monster._Wind._50301MaoDa;

public class Wind_Death : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	protected override IEnumerator DoMainLogic()
	{
		SetCloseBlockEnable();
		SendDeclareDeadEvent();
		KillActors(GetTargetByTeammateIndex(1));
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
