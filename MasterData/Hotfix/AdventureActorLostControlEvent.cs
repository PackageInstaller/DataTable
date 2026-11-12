public class AdventureActorLostControlEvent : BaseAdventureEvent
{
	public AdventureActor actor;

	public static AdventureActorLostControlEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorLostControlEvent>("ADVENTURE_ACTOR_LOSTCONTROL");
	}

	public AdventureActorLostControlEvent()
		: base("ADVENTURE_ACTOR_LOSTCONTROL")
	{
	}

	public override void Clear()
	{
		actor = null;
	}
}
