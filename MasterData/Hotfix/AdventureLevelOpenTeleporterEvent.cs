public class AdventureLevelOpenTeleporterEvent : BaseAdventureEvent
{
	public static AdventureLevelOpenTeleporterEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelOpenTeleporterEvent>("LUA2CSHARP_ROGUELIKE_OPENTELEPORTER");
	}

	public AdventureLevelOpenTeleporterEvent()
		: base("LUA2CSHARP_ROGUELIKE_OPENTELEPORTER")
	{
	}

	public override void Clear()
	{
	}
}
