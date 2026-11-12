using System.Collections;

namespace AIScript.Monster._Fire._50181ShunYiGuai;

public class Fire_Attack03_Spawn : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack03 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	protected override void OnSkillEnable()
	{
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitFrame(1);
		yield return null;
	}
}
