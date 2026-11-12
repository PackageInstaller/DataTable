public class AdventureLevelEndEvent : BaseAdventureEvent
{
	public static AdventureLevelEndEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelEndEvent>("ADVENTURE_LEVEL_END");
	}

	public AdventureLevelEndEvent()
		: base("ADVENTURE_LEVEL_END")
	{
	}

	public override void Clear()
	{
	}
}
