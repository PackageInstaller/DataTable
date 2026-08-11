using Ase.ECS;

namespace Ase;

public class SkillResChargeCount : HeroInDependentData
{
	private HeroSkillData heroSkillData;

	public override void CalculateFillAmount()
	{
		if (heroSkillData == null)
		{
			base.ResFillAmount = 1f;
			return;
		}
		if (base.CurrentFill != heroSkillData.SkillCoolingData.CurrentChargeNumber)
		{
			base.CurrentFill = heroSkillData.SkillCoolingData.CurrentChargeNumber;
		}
		if (base.MaxFill != heroSkillData.SkillCoolingData.MaxChargeNumber)
		{
			base.MaxFill = heroSkillData.SkillCoolingData.MaxChargeNumber;
		}
		if (heroSkillData.SkillCoolingData.ChargeTime != 0f)
		{
			base.ResFillAmount = heroSkillData.SkillCoolingData.CurrentChargeTime / heroSkillData.SkillCoolingData.ChargeTime;
		}
	}

	public static SkillResChargeCount Create(BaseEntity entity, int skillId)
	{
		SkillResChargeCount obj = new SkillResChargeCount
		{
			OwnBaseEntity = entity
		};
		HeroSkillData skillData = entity.GetComponent<SkillComponent>().GetSkillData(skillId);
		obj.heroSkillData = skillData;
		return obj;
	}
}
