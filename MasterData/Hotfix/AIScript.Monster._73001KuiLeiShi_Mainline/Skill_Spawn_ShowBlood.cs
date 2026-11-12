using System.Collections;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_Spawn_ShowBlood : SkillSimpleBase
{
	private bool finished;

	protected override void OnSkillEnable()
	{
		finished = false;
	}

	protected override void OnSkillDisable()
	{
		if (!finished)
		{
			ClearOwnerBullet();
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		ShowCenterHpBar();
		finished = true;
		yield return WaitTime(1);
	}
}
