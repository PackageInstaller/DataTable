using System.Collections;
using TrueSync;

namespace AIScript.Monster._50101YinYing;

public class Skill_Spawn : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		SetBattleOutEnable();
		Skill_Spawn skill_Spawn = this;
		TSVector2 position = GetPosition();
		skill_Spawn.PlayEffect("fx_switch_monster_actor_easy", 1f, default, position);
		yield return WaitTime(1);
		SetHideModelDisable();
		SetBattleOutDisable();
		ShowCenterHpBar();
	}
}
