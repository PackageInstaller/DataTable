public class AdventurePlayerEnterEvent : BaseAdventureEvent
{
	public PlayerAdventureActor player;

	public static AdventurePlayerEnterEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurePlayerEnterEvent>("ADVENTURE_PLAYER_ENTER");
	}

	public AdventurePlayerEnterEvent()
		: base("ADVENTURE_PLAYER_ENTER")
	{
	}

	public override void Clear()
	{
		player = null;
	}
}
