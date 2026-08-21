using Ase.ECS;
using GameFramework;

namespace Ase;

public class MultiLightAttribute : MultiAttributeBase
{
	public static MultiLightAttribute Create(MultiPlayerSystem multiPlayerSystem, DRAttributeMatching cfg)
	{
		MultiLightAttribute multiLightAttribute = ReferencePool.Acquire<MultiLightAttribute>();
		multiLightAttribute.multiPlayerSystem = multiPlayerSystem;
		multiLightAttribute.attributeMatchingCfg = cfg;
		multiLightAttribute.attributeEnum = HeroAttributeEnum.Light;
		return multiLightAttribute;
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
