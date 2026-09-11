using Entitas;

public class EntityCollisionInfo : IComponent
{
	public SimEntity contactEntity;

	public CollisionStatus collisionStatus;
}
