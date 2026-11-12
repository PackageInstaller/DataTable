using System.Collections;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_Spawn_P1 : SkillSimpleBase
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
		AddBuffToTarget(_actor, 720130108);
		yield return WaitTime(0.1);
		finished = true;
		yield return WaitTime(1);
	}
}
