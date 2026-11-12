using System.Collections;

namespace AIScript.Monster._Earth._50311DaWuGui;

public class Earth_Death : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Atk = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	protected override IEnumerator DoMainLogic()
	{
		SetCloseBlockEnable();
		SendDeclareDeadEvent();
		KillActors(GetTargetByTeammateIndex(1));
		BeginAttack(1, Atk, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(4);
	}
}
