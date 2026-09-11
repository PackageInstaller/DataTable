public class EntityCollisionEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mEntity1;

	public int mEntity2;

	public EntityCollisionEvent(int collision1, int collision2)
	{
		mEntity1 = collision1;
		mEntity2 = collision2;
	}

	public override void OnEnterPool()
	{
	}

	public override void Release()
	{
	}
}
