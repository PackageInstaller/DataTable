public class AdventureLevelFinishEvent : BaseAdventureEvent
{
	public static AdventureLevelFinishEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelFinishEvent>("ADVENTURE_LEVEL_FINISH");
	}

	public AdventureLevelFinishEvent()
		: base("ADVENTURE_LEVEL_FINISH")
	{
	}

	public override void Clear()
	{
	}
}
