using System.Collections;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_Born_SiXianKuiLei : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return null;
	}
}
