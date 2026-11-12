using System.Collections;

namespace AIScript.Monster._13041MiNieWa;

public class Skill_Born_LD : SkillSimpleBase
{
	private static readonly int ActionIndex02 = 1;

	private static readonly string ActionCombo02 = "Born";

	private static readonly int ActionIndex01 = 2;

	private static readonly string ActionCombo01 = "Born_Slow";

	protected override IEnumerator DoMainLogic()
	{
		ShowCenterHpBar();
		yield break;
	}
}
