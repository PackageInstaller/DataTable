using ACT.Battle;

namespace Bamboo.ECS;

public static class Entity_Extension_Product
{
	public static Entity GetCaster(this Entity entity)
	{
		if (!entity.TryGetCompProduct(out CompProduct component))
		{
			return entity;
		}
		return component.caster;
	}

	public static Entity GetActionSource(this Entity entity)
	{
		if (!entity.TryGetCompProduct(out CompProduct component))
		{
			return entity;
		}
		return component.actionSource;
	}
}
