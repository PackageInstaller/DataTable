public class AdventurActorSpawned : BaseAdventureEvent
{
	public static AdventurActorSpawned Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurActorSpawned>("ADVENTURE_ACTOR_SPAWN");
	}

	public AdventurActorSpawned()
		: base("ADVENTURE_ACTOR_SPAWN")
	{
	}
}
