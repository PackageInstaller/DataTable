using Entitas;

[Sim]
public class EntityActionManualInput : IComponent, IComponentReset
{
	public EntityActionStatus mStatus;

	public int mInputKey;

	public long mInputStamp;

	public bool mCanDestroy;

	public bool mIsPressing;

	public void Reset(Entity entity)
	{
		mInputKey = -1;
		mInputStamp = 0L;
	}
}
