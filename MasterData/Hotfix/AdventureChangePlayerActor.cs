public class AdventureChangePlayerActor : BaseAdventureEvent
{
	public static AdventureChangePlayerActor Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureChangePlayerActor>("ADVENTURE_CHANGE_PLAYER_ACTOR");
	}

	public AdventureChangePlayerActor()
		: base("ADVENTURE_CHANGE_PLAYER_ACTOR")
	{
	}
}
