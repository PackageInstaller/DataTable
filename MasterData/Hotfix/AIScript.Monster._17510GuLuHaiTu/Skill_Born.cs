using System.Collections;
using TrueSync;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_Born : SkillScript_Base
{
	private bool beInterrupted;

	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, SkillScript_Base.sinkStateTag, value: true);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (beInterrupted)
		{
			SetHideModelDisable();
			SetBattleOutDisable();
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		beInterrupted = true;
		SetBattleOutEnable();
		SetHideModelEnable();
		Skill_Born skill_Born = this;
		TSVector2 position = GetPosition();
		skill_Born.PlayEffect("fx_common_base_monster_in_ground", 1f, default, position);
		yield return WaitTime(0.15);
		Skill_Born skill_Born2 = this;
		position = GetPosition();
		skill_Born2.PlayEffect("fx_common_base_monster_in", 1f, default, position);
		SetHideModelDisable();
		yield return WaitTime(0.5);
		ShowCenterHpBar();
		TriggerOpLisener("BattleStart");
		SetBattleOutDisable();
		beInterrupted = false;
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
	}
}
