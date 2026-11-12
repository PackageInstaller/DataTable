using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._Water._HardLevel._50020ShaYuFaShi;

public class HardLevel_Water_Kill : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		ClearActors(new List<LogicEntity> { _actor });
		yield return null;
	}
}
