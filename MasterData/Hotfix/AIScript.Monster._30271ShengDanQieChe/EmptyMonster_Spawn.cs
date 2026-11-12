using System.Collections;

namespace AIScript.Monster._30271ShengDanQieChe;

public class EmptyMonster_Spawn : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		yield break;
	}
}
