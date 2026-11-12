public class AdventureBullutHitTrigger : BaseAdventureEvent
{
	public AdventureActor fromActor;

	public AdventureActor toActor;

	public static AdventureBullutHitTrigger Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureBullutHitTrigger>("TRIGGER_BULLUT_HIT");
	}

	public AdventureBullutHitTrigger()
		: base("TRIGGER_BULLUT_HIT")
	{
	}

	public override void Clear()
	{
		fromActor = null;
		toActor = null;
	}
}
