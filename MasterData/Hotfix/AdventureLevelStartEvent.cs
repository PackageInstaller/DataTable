public class AdventureLevelStartEvent : BaseAdventureEvent
{
	public static AdventureLevelStartEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelStartEvent>("ADVENTURE_LEVEL_START");
	}

	public AdventureLevelStartEvent()
		: base("ADVENTURE_LEVEL_START")
	{
	}

	public override void Clear()
	{
	}
}
