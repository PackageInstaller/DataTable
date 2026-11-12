public class AdventureLevelTimelineLoadingViewEvent : BaseAdventureEvent
{
	public bool isStart;

	public static AdventureLevelTimelineLoadingViewEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelTimelineLoadingViewEvent>("LEVEL_TIMELINE_LOADINGVIEW");
	}

	public AdventureLevelTimelineLoadingViewEvent()
		: base("LEVEL_TIMELINE_LOADINGVIEW")
	{
	}

	public override void Clear()
	{
	}
}
