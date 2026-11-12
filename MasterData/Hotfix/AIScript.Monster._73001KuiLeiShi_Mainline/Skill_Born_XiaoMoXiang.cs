using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_Born_XiaoMoXiang : SkillSimpleBase
{
	private readonly string fx_Alias = "fx_switch_monster_actor";

	private PlayFX _playFx;

	private bool finished;

	protected override void OnSkillEnable()
	{
		finished = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (!finished)
		{
			ClearOwnerBullet();
		}
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
		ShowCenterHpBar();
		finished = true;
	}
}
