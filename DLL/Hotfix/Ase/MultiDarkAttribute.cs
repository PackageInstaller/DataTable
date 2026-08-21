using Ase.ECS;
using GameFramework;

namespace Ase;

public class MultiDarkAttribute : MultiAttributeBase
{
	public static MultiDarkAttribute Create(MultiPlayerSystem multiPlayerSystem, DRAttributeMatching cfg)
	{
		MultiDarkAttribute multiDarkAttribute = ReferencePool.Acquire<MultiDarkAttribute>();
		multiDarkAttribute.multiPlayerSystem = multiPlayerSystem;
		multiDarkAttribute.attributeMatchingCfg = cfg;
		multiDarkAttribute.attributeEnum = HeroAttributeEnum.Dark;
		return multiDarkAttribute;
	}

	protected override void OnInit()
	{
	}

	public override void OnUpdate(float delta)
	{
	}

	public override void CreateEntityMessager(BaseEntity entity)
	{
		base.CreateEntityMessager(entity);
		OnAddBuffs(entity);
	}

	public override void SkillReleaseMessager(BaseEntity entity, HeroSkillTypeEnum skillTypeEnum, int skillId)
	{
		base.SkillReleaseMessager(entity, skillTypeEnum, skillId);
	}

	public override void OnClear()
	{
	}
}
