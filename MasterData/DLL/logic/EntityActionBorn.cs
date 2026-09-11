using Entitas;

public class EntityActionBorn : IComponent, IComponentReset
{
	public EntityActionStatus mStatus;

	public int mBornDuring;

	public void Reset(Entity entity)
	{
	}
}
