using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster.Activity.BreakOut;

public class Skill_Stay : SkillSimpleBase
{
	private readonly string fx_Alias = "fx_switch_monster_actor";

	private PlayFX _playFx;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(180);
	}
}
