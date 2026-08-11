using Ase.ECS;
using GameFramework;

namespace Ase;

public class MultiFireAttribute : MultiAttributeBase
{
	public static MultiFireAttribute Create(MultiPlayerSystem multiPlayerSystem, DRAttributeMatching cfg)
	{
		MultiFireAttribute multiFireAttribute = ReferencePool.Acquire<MultiFireAttribute>();
		multiFireAttribute.multiPlayerSystem = multiPlayerSystem;
		multiFireAttribute.attributeMatchingCfg = cfg;
		multiFireAttribute.attributeEnum = HeroAttributeEnum.Fire;
		return multiFireAttribute;
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
