using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._Earth._50311DaWuGui;

public class Earth_JieJin_Attack01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Atk = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Atk, flushInputedKeys: true, forceInterruptAttack: true);
		SetUnparalleledEnable();
		SetSearchedImmunityEnable();
		SetHideModelEnable();
		yield return WaitTime(1.1);
		ClearActors(new List<LogicEntity> { _actor });
	}
}
