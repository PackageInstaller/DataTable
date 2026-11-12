using System.Collections;

namespace AIScript.Monster._HardLevel._50101YinYing;

public class HardLevel_Spawn_Kill : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
	}
}
