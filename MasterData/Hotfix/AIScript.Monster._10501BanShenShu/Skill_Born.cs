using System.Collections;
using TrueSync;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_Born : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		ShowCenterHpBar();
		TriggerOpLisener("BattleStart");
	}

	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable();
		SetHideModelEnable();
		Skill_Born skill_Born = this;
		TSVector2 position = GetPosition();
		skill_Born.PlayEffect("fx_common_base_monster_in_ground", 1f, default, position);
		yield return WaitTime(0.15);
		Skill_Born skill_Born2 = this;
		position = GetPosition();
		skill_Born2.PlayEffect("fx_common_base_monster_in", 1f, default, position);
		yield return WaitTime(0.5);
		SetHideModelDisable();
		TSVector2 targetPOS = GetEntityPositionObsoleted(GetCurrentPlayer());
		while (Distance(targetPOS, GetPosition()) >= 12)
		{
			targetPOS = GetEntityPositionObsoleted(GetCurrentPlayer());
			yield return WaitTime(0.2);
		}
		SetBattleOutDisable();
	}
}
