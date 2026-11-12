public class AdventureActorBeginReload : BaseAdventureEvent
{
	public static AdventureActorBeginReload Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorBeginReload>("ACTOR_BEGIN_RELOAD");
	}

	public AdventureActorBeginReload()
		: base("ACTOR_BEGIN_RELOAD")
	{
	}
}
