public class AdventureLevelStopTimingEvent : BaseAdventureEvent
{
	public static AdventureLevelStopTimingEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelStopTimingEvent>("LEVEL_STOP_TIMING");
	}

	public AdventureLevelStopTimingEvent()
		: base("LEVEL_STOP_TIMING")
	{
	}

	public override void Clear()
	{
	}
}
