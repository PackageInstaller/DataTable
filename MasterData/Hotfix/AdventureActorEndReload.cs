public class AdventureActorEndReload : BaseAdventureEvent
{
	public static AdventureActorEndReload Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorEndReload>("ACTOR_END_RELOAD");
	}

	public AdventureActorEndReload()
		: base("ACTOR_END_RELOAD")
	{
	}
}
