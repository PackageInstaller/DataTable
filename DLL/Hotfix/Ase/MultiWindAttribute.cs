using Ase.ECS;
using GameFramework;

namespace Ase;

public class MultiWindAttribute : MultiAttributeBase
{
	public static MultiWindAttribute Create(MultiPlayerSystem multiPlayerSystem, DRAttributeMatching cfg)
	{
		MultiWindAttribute multiWindAttribute = ReferencePool.Acquire<MultiWindAttribute>();
		multiWindAttribute.multiPlayerSystem = multiPlayerSystem;
		multiWindAttribute.attributeMatchingCfg = cfg;
		multiWindAttribute.attributeEnum = HeroAttributeEnum.Wind;
		return multiWindAttribute;
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
