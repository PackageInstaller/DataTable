using System.Collections;

namespace AIScript.Monster._30931HaSaNa;

public class Skill_Spawn_Device_CommonLevel : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		DispatchCustomEvent("ActiveCommon");
		yield return WaitTime(2);
	}
}
