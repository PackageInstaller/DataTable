using System.Collections;

namespace AIScript.Monster.Common;

public class Skill_ShowBlood : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		ShowBlood(isShow: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
	}
}
