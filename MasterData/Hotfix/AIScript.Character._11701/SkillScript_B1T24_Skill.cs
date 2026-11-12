using TrueSync;

namespace AIScript.Character._11701;

public class SkillScript_B1T24_Skill : SkillScript_B1_Skill
{
	private readonly string _areaEffectAlias_level1 = "AreaEffect_117_B1T2_Skill_ElectricCircle_Large";

	private readonly string _areaEffectAlias_level2 = "AreaEffect_117_B1T2_Skill_ElectricCircle_Large";

	private readonly string _areaEffectAlias_level3 = "AreaEffect_117_B1T2_Skill_ElectricCircle_Large";

	private readonly string _areaEffectAlias_level4 = "AreaEffect_117_B1T2_Skill_ElectricCircle_Large";

	private readonly string _areaEffectAlias_level5 = "AreaEffect_117_B1T2_Skill_ElectricCircle_Large";

	private readonly string _bulletAlias_level1 = "Bullet_11701_B1T24_Skill_LargeBoom";

	private readonly string _bulletAlias_level2 = "Bullet_11701_B1T24_Skill_LargeBoom";

	private readonly string _bulletAlias_level3 = "Bullet_11701_B1T24_Skill_LargeBoom";

	private readonly string _bulletAlias_level4 = "Bullet_11701_B1T24_Skill_LargeBoom";

	private readonly string _bulletAlias_level5 = "Bullet_11701_B1T24_Skill_LargeBoom";

	private readonly FP _areaEffectDistance = 3;

	private readonly FP _areaEffectRadius = 4;

	protected override void CustomAction(string areaEffectAlias, FP distance, FP areaEffectRadius, string bulletAlias)
	{
		string areaEffectAlias2 = _areaEffectAlias_level1;
		string bulletAlias2 = _bulletAlias_level1;
		switch (((PlayerAdventureActor)_actor).GetTalentGroupLevel())
		{
		case 2:
			areaEffectAlias2 = _areaEffectAlias_level2;
			bulletAlias2 = _bulletAlias_level2;
			break;
		case 3:
			areaEffectAlias2 = _areaEffectAlias_level3;
			bulletAlias2 = _bulletAlias_level3;
			break;
		case 4:
			areaEffectAlias2 = _areaEffectAlias_level4;
			bulletAlias2 = _bulletAlias_level4;
			break;
		case 5:
			areaEffectAlias2 = _areaEffectAlias_level5;
			bulletAlias2 = _bulletAlias_level5;
			break;
		}
		base.CustomAction(areaEffectAlias2, _areaEffectDistance, _areaEffectRadius, bulletAlias2);
	}
}
