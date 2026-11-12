using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Summon_Smash2_Phase_1 : SkillSimpleBase
{
	private string key_smash = "Book_Skill06_Ring";

	private string areaEffect_Ring = "Area_70001_Book_Skill06_Ring";

	private long Effect01;

	protected override void OnSkillDisable()
	{
		StopEffect(Effect01);
	}

	protected override IEnumerator DoMainLogic()
	{
		Effect01 = PlayEffect("fx_m70001_book_base_skill07_3_ringwave_2s", 1f, 0, _actor.tsTransform.Position);
		yield return WaitTime(1);
		StopEffect(Effect01);
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_Ring, _actor.tsTransform.Position);
		yield return WaitTime(1);
	}
}
