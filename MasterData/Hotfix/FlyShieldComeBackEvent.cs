public class FlyShieldComeBackEvent : BaseAdventureEvent
{
	public AdventureActor owner;

	public static FlyShieldComeBackEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<FlyShieldComeBackEvent>("FLY_SHIELD_COMEBACK");
	}

	public FlyShieldComeBackEvent()
		: base("FLY_SHIELD_COMEBACK")
	{
	}

	public override void Clear()
	{
		owner = null;
	}
}
