public class AdventurePlayerLeaveEvent : BaseAdventureEvent
{
	public PlayerAdventureActor player;

	public static AdventurePlayerLeaveEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurePlayerLeaveEvent>("ADVENTURE_PLAYER_LEAVE");
	}

	public AdventurePlayerLeaveEvent()
		: base("ADVENTURE_PLAYER_LEAVE")
	{
	}

	public override void Clear()
	{
		player = null;
	}
}
