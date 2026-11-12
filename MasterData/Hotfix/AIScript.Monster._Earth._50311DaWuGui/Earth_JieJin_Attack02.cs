using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._Earth._50311DaWuGui;

public class Earth_JieJin_Attack02 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Atk = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.I };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Atk, flushInputedKeys: true, forceInterruptAttack: true);
		SetUnparalleledEnable();
		SetSearchedImmunityEnable();
		yield return WaitCustomEvent("Hide");
		SetHideModelEnable();
		yield return WaitTime(1);
		ClearActors(new List<LogicEntity> { _actor });
	}
}
