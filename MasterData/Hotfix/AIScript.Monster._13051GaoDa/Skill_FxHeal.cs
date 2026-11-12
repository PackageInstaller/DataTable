using System.Collections;

namespace AIScript.Monster._13051GaoDa;

public class Skill_FxHeal : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		PlayEffect("HealPrologue");
		yield break;
	}
}
