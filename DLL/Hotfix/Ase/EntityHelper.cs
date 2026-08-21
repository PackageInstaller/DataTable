using Ase.ECS;

namespace Ase;

public static class EntityHelper
{
	public static T GetSystem<T>(this BaseEntity entity) where T : BaseSystem
	{
		return entity.GetWorld().GetSystem<T>();
	}
}
