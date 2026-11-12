public class ActorRefreshFateCardTheme : BaseAdventureEvent
{
	public static ActorRefreshFateCardTheme Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<ActorRefreshFateCardTheme>("ACTOR_REFRESH_FATECARD_THEME");
	}

	public ActorRefreshFateCardTheme()
		: base("ACTOR_REFRESH_FATECARD_THEME")
	{
	}
}
