public class AdventurePlayeSpawnCompleteEvent : BaseAdventureEvent
{
	public static AdventurePlayeSpawnCompleteEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurePlayeSpawnCompleteEvent>("PLAYER_SPAWN_COMPLETE");
	}

	public AdventurePlayeSpawnCompleteEvent()
		: base("PLAYER_SPAWN_COMPLETE")
	{
	}

	public override void Clear()
	{
	}
}
