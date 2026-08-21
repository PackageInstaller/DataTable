using Entitas;

public class EntityActionIdle : IComponent, IComponentReset
{
	public EntityActionStatus mStatus;

	public void Reset(Entity entity)
	{
	}
}
