public class AdventureActorBeControlledEvent : BaseAdventureEvent
{
	public AdventureActor actor;

	public static AdventureActorBeControlledEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorBeControlledEvent>("ADVENTURE_ACTOR_BE_CONTROLLED");
	}

	public AdventureActorBeControlledEvent()
		: base("ADVENTURE_ACTOR_BE_CONTROLLED")
	{
	}

	public override void Clear()
	{
		actor = null;
	}
}
