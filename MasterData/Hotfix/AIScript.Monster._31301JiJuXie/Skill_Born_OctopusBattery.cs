using System.Collections;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Born_OctopusBattery : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		yield return null;
		SetHideModelDisable();
		yield return WaitTime(0.3);
	}
}
