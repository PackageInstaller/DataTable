public class ActorRefreshThemePerk : BaseAdventureEvent
{
	public AdventureActor owner;

	public static ActorRefreshThemePerk Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<ActorRefreshThemePerk>("ACTOR_REFRESH_THEMEPERK");
	}

	public ActorRefreshThemePerk()
		: base("ACTOR_REFRESH_THEMEPERK")
	{
	}

	public override void Clear()
	{
		owner = null;
	}
}
