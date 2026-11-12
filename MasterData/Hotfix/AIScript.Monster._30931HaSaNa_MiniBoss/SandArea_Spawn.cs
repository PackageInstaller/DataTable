using System.Collections;

namespace AIScript.Monster._30931HaSaNa_MiniBoss;

public class SandArea_Spawn : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		yield return null;
		SetLogicTagFpValue(_actor, "TeammateID", 1);
	}
}
