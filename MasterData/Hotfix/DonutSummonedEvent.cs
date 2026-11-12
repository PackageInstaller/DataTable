public class DonutSummonedEvent : BaseAdventureEvent
{
	public bool beginSpawn;

	public bool finishDied;

	public bool battleReadyDestroy;

	public static DonutSummonedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<DonutSummonedEvent>("DONUT_SUMMONED_EVENT");
	}

	public DonutSummonedEvent()
		: base("DONUT_SUMMONED_EVENT")
	{
	}

	public override void Clear()
	{
		beginSpawn = false;
		finishDied = false;
		battleReadyDestroy = false;
	}
}
