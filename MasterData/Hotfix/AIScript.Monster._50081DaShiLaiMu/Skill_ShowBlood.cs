using System.Collections;

namespace AIScript.Monster._50081DaShiLaiMu;

public class Skill_ShowBlood : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		ShowCenterHpBar();
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
	}
}
