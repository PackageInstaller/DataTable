using System.Collections;

namespace AIScript.Monster._30931HaSaNa;

public class Skill_Spawn : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		ShowCenterHpBar();
		yield break;
	}
}
