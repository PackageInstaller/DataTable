public class WindBladeReboundEvent : BaseAdventureEvent
{
	public AdventureActor owner;

	public AdventureWindBlade windBlade;

	public int reboundTime;

	public bool reboundWithPlayer;

	public static WindBladeReboundEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<WindBladeReboundEvent>("WINDBLADE_REBOUND");
	}

	public WindBladeReboundEvent()
		: base("WINDBLADE_REBOUND")
	{
	}

	public override void Clear()
	{
		owner = null;
		windBlade = null;
		reboundTime = 0;
		reboundWithPlayer = false;
	}
}
