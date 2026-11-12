public class AdventureActorFinishReload : BaseAdventureEvent
{
	public static AdventureActorFinishReload Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorFinishReload>("ACTOR_FINISH_RELOAD");
	}

	public AdventureActorFinishReload()
		: base("ACTOR_FINISH_RELOAD")
	{
	}
}
