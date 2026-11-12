public class AdventureLevelStartTimingEvent : BaseAdventureEvent
{
	public static AdventureLevelStartTimingEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelStartTimingEvent>("LEVEL_START_TIMING");
	}

	public AdventureLevelStartTimingEvent()
		: base("LEVEL_START_TIMING")
	{
	}

	public override void Clear()
	{
	}
}
