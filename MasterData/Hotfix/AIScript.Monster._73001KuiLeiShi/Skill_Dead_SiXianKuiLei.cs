using System.Collections;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_Dead_SiXianKuiLei : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		SetUnparalleledDisable();
		SetCloseBlockDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return null;
	}
}
