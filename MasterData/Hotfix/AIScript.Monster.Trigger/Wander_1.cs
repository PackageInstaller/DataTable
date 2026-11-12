using System.Collections;

namespace AIScript.Monster.Trigger;

public class Wander_1 : SkillSimpleBase
{
	private int time = 10000;

	private int damage = 1;

	private int damage1 = -1;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		while (true)
		{
			PlayEffect("fx_screen_actor_hit", 1f, 1, GetPosition(), 0);
			yield return WaitTime(0.5);
		}
	}
}
