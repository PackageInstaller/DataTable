public class ActorRefreshFateCardInfo : BaseAdventureEvent
{
	public static ActorRefreshFateCardInfo Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<ActorRefreshFateCardInfo>("ACTOR_REFRESH_FATECARD_INFO");
	}

	public ActorRefreshFateCardInfo()
		: base("ACTOR_REFRESH_FATECARD_INFO")
	{
	}
}
