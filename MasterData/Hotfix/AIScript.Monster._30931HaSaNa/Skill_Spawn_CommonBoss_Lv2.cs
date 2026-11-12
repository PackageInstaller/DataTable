using System.Collections;

namespace AIScript.Monster._30931HaSaNa;

public class Skill_Spawn_CommonBoss_Lv2 : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		ShowCenterHpBar();
		SetLogicTagFpValue(_actor, "Difficulty", 2);
		yield break;
	}
}
