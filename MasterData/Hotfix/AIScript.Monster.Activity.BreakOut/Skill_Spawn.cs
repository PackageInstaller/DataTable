#define LOG_DEBUG
using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster.Activity.BreakOut;

public class Skill_Spawn : SkillSimpleBase
{
	private readonly string fx_Alias = "fx_switch_monster_actor";

	private PlayFX _playFx;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.Action();
		NovaLogger.Debug("进入Action");
	}

	protected override IEnumerator DoMainLogic()
	{
		SetHideOutEnable();
		SetHideModelEnable();
		SetImmuneControlEnable();
		PlayEffect(fx_Alias, 1f, default, GetPosition(), GetEntityAngle(_actor));
		yield return WaitTime(1);
		SetImmuneControlDisable();
		SetHideModelDisable();
		SetHideOutDisable();
	}
}
