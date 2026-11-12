using System.Collections;
using TrueSync;

namespace AIScript.Monster._50311DaWuGui;

public class DaWuGui_Linger : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Linger = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.K };

	protected TSVector2 TargetPosition;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Linger, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(3);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
