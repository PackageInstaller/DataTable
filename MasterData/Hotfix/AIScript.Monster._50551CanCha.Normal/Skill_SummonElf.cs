using System.Collections;
using TrueSync;

namespace AIScript.Monster._50551CanCha.Normal;

public class Skill_SummonElf : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SummonTeammate(4, TSVector2.zero, GetForward(), 1);
		yield break;
	}
}
