using System.Collections;

namespace AIScript.Monster.TowerDefense.Skill;

public class Skill_Spawn_Common : SkillSimpleBase
{
	private readonly string fx_Alias = "fx_td_base_monster_born";

	protected override IEnumerator DoMainLogic()
	{
		SetHideOutEnable();
		SetImmuneControlEnable();
		PlayEffect(fx_Alias, 1f, default, GetPosition(), GetEntityAngle(_actor));
		yield return WaitTime(0.25);
		SetImmuneControlDisable();
		SetHideOutDisable();
	}
}
