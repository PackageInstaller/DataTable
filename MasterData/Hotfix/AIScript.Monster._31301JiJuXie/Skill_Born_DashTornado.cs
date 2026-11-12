using System.Collections;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Born_DashTornado : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitFrame(1);
	}
}
