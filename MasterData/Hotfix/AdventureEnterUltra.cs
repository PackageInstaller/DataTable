public class AdventureEnterUltra : BaseAdventureEvent
{
	public static AdventureEnterUltra Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureEnterUltra>("ACTOR_ENTER_ULTRA");
	}

	public AdventureEnterUltra()
		: base("ACTOR_ENTER_ULTRA")
	{
	}

	public override void Clear()
	{
	}
}
