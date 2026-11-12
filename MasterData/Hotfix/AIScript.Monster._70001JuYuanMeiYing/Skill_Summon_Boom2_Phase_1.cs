using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Summon_Boom2_Phase_1 : SkillSimpleBase
{
	private string key_Base = "Book_Skill02_Boom";

	private string areaEffect_Boom = "Area_70001_Book_Skill02_Boom";

	private long Effect01;

	protected override void OnSkillDisable()
	{
		StopEffect(Effect01);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		StopEffect(Effect01);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.6);
		Effect01 = PlayEffect("fx_m70001_base_skill03_02_follow_new", 1f, 0, _actor.tsTransform.Position);
		yield return WaitTime(1);
		StopEffect(Effect01);
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_Boom, _actor.tsTransform.Position);
		yield return WaitTime(0.4);
	}
}
