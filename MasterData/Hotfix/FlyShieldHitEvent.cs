public class FlyShieldHitEvent : BaseAdventureEvent
{
	public AdventureActor owner;

	public AdventureActor target;

	public int reboundTime;

	public static FlyShieldHitEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<FlyShieldHitEvent>("FLY_SHIELD_HIT");
	}

	public FlyShieldHitEvent()
		: base("FLY_SHIELD_HIT")
	{
	}

	public override void Clear()
	{
		target = null;
		reboundTime = 0;
	}
}
