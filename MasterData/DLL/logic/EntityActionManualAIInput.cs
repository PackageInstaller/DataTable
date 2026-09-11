using Entitas;

[Sim]
public class EntityActionManualAIInput : IComponent, IComponentReset
{
	public EntityActionStatus mStatus;

	public int mInputKey;

	public bool mCanDestroy;

	public bool mIsPressing;

	public void Reset(Entity entity)
	{
		mInputKey = -1;
		mCanDestroy = true;
		mIsPressing = false;
	}
}
