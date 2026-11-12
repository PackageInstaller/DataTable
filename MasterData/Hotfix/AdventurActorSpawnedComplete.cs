public class AdventurActorSpawnedComplete : BaseAdventureEvent
{
	public static AdventurActorSpawnedComplete Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurActorSpawnedComplete>("ADVENTURE_ACTOR_SPAWN_COMPLRTR");
	}

	public AdventurActorSpawnedComplete()
		: base("ADVENTURE_ACTOR_SPAWN_COMPLRTR")
	{
	}
}
