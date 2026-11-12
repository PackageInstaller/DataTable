using TrueSync;

public class InteractiveTeleporter : InteractiveSimple
{
	public enum TeleportType
	{
		ByUIClick,
		ByEnterArea
	}

	public FP delayHidePlayerTime = 1f;

	public TeleportType teleportType;

	protected override void SetMeshCollider()
	{
		base.SetMeshCollider();
		InteractiveManager.interactiveState tempInteractiveState = _tempInteractiveState;
		bool navmeshCut = tempInteractiveState == InteractiveManager.interactiveState.deactive1 || tempInteractiveState == InteractiveManager.interactiveState.deactive0;
		interCollider?.SetNavmeshCut(navmeshCut);
	}

	public override void FireUiEvent(bool active = false)
	{
		if (teleportType == TeleportType.ByUIClick)
		{
			base.FireUiEvent(active);
		}
		else if (active && (battleStatCanTrigger || !ModuleController<AdventureModuleController>.Instance.InBattleState) && (interOperatons.Count <= 0 || !interOperatons.get_Item(0).iAwakeState || !interOperatons.get_Item(0).isActive))
		{
			DoEventAction(_playerOp: false);
		}
	}
}
