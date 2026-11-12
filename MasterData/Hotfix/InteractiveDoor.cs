public class InteractiveDoor : InteractiveBase
{
	protected override bool initState()
	{
		base.initState();
		return true;
	}

	protected override void SetMeshCollider()
	{
		base.SetMeshCollider();
		InteractiveManager.interactiveState tempInteractiveState = _tempInteractiveState;
		bool navmeshCut = tempInteractiveState == InteractiveManager.interactiveState.active0 || tempInteractiveState == InteractiveManager.interactiveState.deactive0;
		interCollider?.SetNavmeshCut(navmeshCut);
	}
}
