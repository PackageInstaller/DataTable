public class AdventureLevelCounterEvent : BaseAdventureEvent
{
	public string counter;

	public static AdventureLevelCounterEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelCounterEvent>("LEVEL_COUNTER");
	}

	public AdventureLevelCounterEvent()
		: base("LEVEL_COUNTER")
	{
	}

	public override void Clear()
	{
	}
}
