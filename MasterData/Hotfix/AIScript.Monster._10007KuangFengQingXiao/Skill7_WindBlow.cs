using System.Collections;

namespace AIScript.Monster._10007KuangFengQingXiao;

public class Skill7_WindBlow : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
	}
}
