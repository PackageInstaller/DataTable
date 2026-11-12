using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster._15510FengNiao;

public class Skill_Flower_Spawn_Hardcore : SkillSimpleBase
{
	private readonly string fx_Alias = "fx_switch_monster_actor";

	private PlayFX _playFx;

	protected override void OnSkillEnable()
	{
		SetImmuneControlEnable(autoDisableWhenSkillDisable: false);
		SetLockHpAbsEnable(isAbs: true, 1, autoDisableWhenSkillDisable: false);
		AddBuffToTarget(_actor, 155105320);
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		SetHideOutEnable();
		SetHideModelEnable();
		PlayEffect(fx_Alias, 1f, default, GetPosition(), GetEntityAngle(_actor));
		yield return WaitTime(1);
		SetHideModelDisable();
		SetHideOutDisable();
	}
}
