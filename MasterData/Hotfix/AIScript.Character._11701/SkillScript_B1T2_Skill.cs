using TrueSync;

namespace AIScript.Character._11701;

public class SkillScript_B1T2_Skill : SkillScript_B1_Skill
{
	private readonly string _areaEffectAlias = "AreaEffect_117_B1T2_Skill_ElectricCircle_Large";

	private readonly FP _areaEffectDistance = 3;

	private readonly FP _areaEffectRadius = 4;

	protected override void CustomAction(string areaEffectAlias, FP distance, FP areaEffectRadius, string bulletAlias)
	{
		base.CustomAction(_areaEffectAlias, _areaEffectDistance, _areaEffectRadius, bulletAlias);
	}
}
