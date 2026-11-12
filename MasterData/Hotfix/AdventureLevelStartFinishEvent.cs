public class AdventureLevelStartFinishEvent : BaseAdventureEvent
{
	public static AdventureLevelStartFinishEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelStartFinishEvent>("ADVENTURE_LEVEL_START_FINISH");
	}

	public AdventureLevelStartFinishEvent()
		: base("ADVENTURE_LEVEL_START_FINISH")
	{
	}

	public override void Clear()
	{
	}
}
