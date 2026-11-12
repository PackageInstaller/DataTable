using System.Collections;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Summon_Laser_Phase_1 : SkillSimpleBase
{
	private string key_Base = "Book_Skill01_Laser";

	private string bullet_Laser = "Weapon_70001_Book_Skill01_Laser";

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.6);
		long Effect01 = PlayEffect("fx_m70001_loop_skill05_energyball_start_book");
		yield return WaitTime(0.8);
		StopEffect(Effect01);
		Shoot(bullet_Laser, _actor.tsTransform.Position, 2, 0);
		yield return WaitTime(3.6);
	}
}
