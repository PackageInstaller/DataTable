using System.Collections;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_Born_ChongNengKuiLei : SkillSimpleBase
{
	private const string combo_Born = "Born";

	private readonly string fx_Alias = "fx_m72014_base_born";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		PlayEffect(fx_Alias, 1f, default, GetPosition(), GetEntityAngle(_actor));
		yield return WaitTime(0.2);
		SetHideModelDisable();
	}
}
