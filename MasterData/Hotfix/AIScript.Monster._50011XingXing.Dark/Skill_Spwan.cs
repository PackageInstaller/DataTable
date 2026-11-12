using System.Collections;

namespace AIScript.Monster._50011XingXing.Dark;

public class Skill_Spwan : SkillSimpleBase
{
	private string spawnFx = "fx_m50011_loop_ground_appear_dark";

	private string spawnEndFx = "fx_switch_monster_actor";

	private long spawnFxID;

	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, "DropAttackSwitch", value: false);
		SetBattleOutEnable();
		SetHideModelEnable();
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		spawnFxID = PlayEffect(spawnFx, 1f, default, GetPosition());
		PlayEffect(spawnEndFx, 1f, default, GetPosition());
		yield return WaitTime(1);
		StopEffect(spawnFxID);
	}
}
