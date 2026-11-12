public class AdventureLevelLoadCompleteEvent : BaseAdventureEvent
{
	public static AdventureLevelLoadCompleteEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelLoadCompleteEvent>("ADVENTURE_LEVEL_LOAD_COMPLETE");
	}

	public AdventureLevelLoadCompleteEvent()
		: base("ADVENTURE_LEVEL_LOAD_COMPLETE")
	{
	}

	public override void Clear()
	{
	}
}
