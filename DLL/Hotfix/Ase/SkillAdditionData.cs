using GameFramework;
using UnityEngine;

namespace Ase;

public class SkillAdditionData : IReference
{
	public float SkillSpecialDamage;

	public float SkillSpecialTenacity;

	public float SkillSpecialCure;

	public float TalentDamageRatio { get; set; }

	public float TalentFixDamageRatio { get; set; }

	public float TalentTenacityRatio { get; set; }

	public float TalentFixTenacityRatio { get; set; }

	public void SetSkillAddition(AdditionKind additionKind, float addition)
	{
		switch (additionKind)
		{
		case AdditionKind.Damage:
			SkillSpecialDamage = Mathf.Clamp(SkillSpecialDamage + addition, 0f, float.MaxValue);
			break;
		case AdditionKind.Tenacity:
			SkillSpecialTenacity = Mathf.Clamp(SkillSpecialTenacity + addition, 0f, float.MaxValue);
			break;
		case AdditionKind.Cure:
			SkillSpecialCure = Mathf.Clamp(SkillSpecialCure + addition, 0f, float.MaxValue);
			break;
		}
	}

	public void CultivateSkillLevel(DRCultivateSkillLevel cultivateSkillLevel)
	{
		TalentDamageRatio += cultivateSkillLevel.TalentDamageRatio;
		TalentFixDamageRatio += cultivateSkillLevel.TalentFixDamageRatio;
		TalentTenacityRatio += cultivateSkillLevel.TalentTenacityRatio;
		TalentFixTenacityRatio += cultivateSkillLevel.TalentFixTenacityRatio;
	}

	public override string ToString()
	{
		return $"技能独立伤害加成:{SkillSpecialDamage} 技能独立削韧加成:{SkillSpecialTenacity} 技能独立治疗加成:{SkillSpecialCure}";
	}

	public void Clear()
	{
		SkillSpecialDamage = 0f;
		SkillSpecialTenacity = 0f;
		SkillSpecialCure = 0f;
	}
}
