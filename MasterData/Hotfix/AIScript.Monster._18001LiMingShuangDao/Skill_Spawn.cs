using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster._18001LiMingShuangDao;

public class Skill_Spawn : SkillSimpleBase
{
	private readonly string fx_Alias = "fx_m18001_switch_monster_actor";

	private PlayFX _playFx;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
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
