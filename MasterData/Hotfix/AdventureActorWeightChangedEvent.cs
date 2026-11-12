public class AdventureActorWeightChangedEvent : BaseAdventureEvent
{
	public long actorId;

	public int originWeight;

	public int finalWeight;

	public static AdventureActorWeightChangedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorWeightChangedEvent>("ACTOR_WEIGHT_CHANGED");
	}

	public AdventureActorWeightChangedEvent()
		: base("ACTOR_WEIGHT_CHANGED")
	{
	}
}
