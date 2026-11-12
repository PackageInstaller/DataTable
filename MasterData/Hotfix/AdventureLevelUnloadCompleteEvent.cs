public class AdventureLevelUnloadCompleteEvent : BaseAdventureEvent
{
	public static AdventureLevelUnloadCompleteEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelUnloadCompleteEvent>("ADVENTURE_LEVEL_UNLOAD_COMPLETE");
	}

	public AdventureLevelUnloadCompleteEvent()
		: base("ADVENTURE_LEVEL_UNLOAD_COMPLETE")
	{
	}

	public override void Clear()
	{
	}
}
