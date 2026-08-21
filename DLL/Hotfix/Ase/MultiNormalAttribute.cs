using Ase.ECS;
using GameFramework;

namespace Ase;

public class MultiNormalAttribute : MultiAttributeBase
{
	public static MultiNormalAttribute Create(MultiPlayerSystem multiPlayerSystem, DRAttributeMatching cfg)
	{
		MultiNormalAttribute multiNormalAttribute = ReferencePool.Acquire<MultiNormalAttribute>();
		multiNormalAttribute.multiPlayerSystem = multiPlayerSystem;
		multiNormalAttribute.attributeMatchingCfg = cfg;
		multiNormalAttribute.attributeEnum = HeroAttributeEnum.Normal;
		return multiNormalAttribute;
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

	public override void OnClear()
	{
	}
}
