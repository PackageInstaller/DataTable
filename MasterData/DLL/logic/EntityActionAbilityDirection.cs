using Entitas;

[Sim]
public class EntityActionAbilityDirection : IComponent, IComponentReset
{
	public EntityActionStatus mStatus;

	public Int3 mDirection;

	public void Reset(Entity entity)
	{
		mStatus = EntityActionStatus.E_ACTIVE;
		mDirection = Int3.zero;
	}
}
