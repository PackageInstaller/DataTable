using System.Collections;

namespace AIScript.Monster._50171BingXiangGuai_IceCube;

public class Spawn : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		yield break;
	}
}
