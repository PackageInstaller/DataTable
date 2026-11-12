using System.Collections;

namespace AIScript.Monster.Trigger;

public class Wander : SkillSimpleBase
{
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
		PlayFeedbackEffect("CameraShake_Down");
		PlayEffect("fx_screen_tenacity_break", 1f, 1, GetPosition(), 0);
		yield return WaitTime(9999f);
	}
}
