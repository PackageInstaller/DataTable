public class AdventureActorMoveSpeedChangedEvent : BaseAdventureEvent
{
	public long actorId;

	public static AdventureActorMoveSpeedChangedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorMoveSpeedChangedEvent>("ACTOR_MOVESPEED_CHANGED");
	}

	public AdventureActorMoveSpeedChangedEvent()
		: base("ACTOR_MOVESPEED_CHANGED")
	{
	}
}
