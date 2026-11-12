public class AdventureActorFailReload : BaseAdventureEvent
{
	public static AdventureActorFailReload Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorFailReload>("ACTOR_FAIL_RELOAD");
	}

	public AdventureActorFailReload()
		: base("ACTOR_FAIL_RELOAD")
	{
	}
}
