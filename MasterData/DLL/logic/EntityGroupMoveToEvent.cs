public class EntityGroupMoveToEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public Int3 mTargetPos;

	public override void OnEnterPool()
	{
	}

	public override void Release()
	{
	}
}
