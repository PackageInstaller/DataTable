using Ase.ECS;

namespace Ase;

public class SkillResLayer : HeroInDependentData
{
	private HeroSkillData heroSkillData;

	public override void CalculateFillAmount()
	{
		if (heroSkillData == null)
		{
			base.ResFillAmount = 1f;
			return;
		}
		if (base.CurrentFill != heroSkillData.CacheLayer)
		{
			base.CurrentFill = heroSkillData.CacheLayer;
		}
		if (base.MaxFill != heroSkillData.MaxCacheLayer)
		{
			base.MaxFill = heroSkillData.MaxCacheLayer;
		}
	}

	public static SkillResLayer Create(BaseEntity entity, int skillId)
	{
		return new SkillResLayer
		{
			OwnBaseEntity = entity,
			heroSkillData = entity.GetComponent<SkillComponent>().GetSkillData(skillId)
		};
	}
}
