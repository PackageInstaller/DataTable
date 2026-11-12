using System.Collections;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_Spawn_Slaves : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetImmuneControlEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		yield break;
	}
}
