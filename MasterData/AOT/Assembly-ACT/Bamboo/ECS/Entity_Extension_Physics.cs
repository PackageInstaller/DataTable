using ACT.Battle;

namespace Bamboo.ECS;

public static class Entity_Extension_Physics
{
	public static void SetMovementMode(this Entity entity, ACTMovementMode mode)
	{
		if (entity.TryGetCompPhysics(out CompPhysics component))
		{
			component.SetMovementMode(mode);
		}
	}
}
