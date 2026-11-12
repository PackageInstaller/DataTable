using System.Collections;

namespace AIScript.Monster.Common;

public class Skill_Wait_NoMove : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		SetSuperArmorEnable(autoDisableWhenSkillDisable: false);
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		while (true)
		{
			yield return WaitTime(GetRandomValue(3, 4));
		}
	}
}
