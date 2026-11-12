using System.Collections;

namespace AIScript.Monster._Water._50181ShunYiGuai;

public class Water_Attack05_Spawn : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack05 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	protected override void OnSkillEnable()
	{
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.8);
		yield return null;
	}
}
