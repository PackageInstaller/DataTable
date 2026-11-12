using System.Collections;

namespace AIScript.Monster._70021MaoYan;

public class Skill_WaitBattle : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		AddBuffToTarget(_actor, 700210000);
	}

	protected override IEnumerator DoMainLogic()
	{
		ShowCenterHpBar();
		yield return null;
	}
}
