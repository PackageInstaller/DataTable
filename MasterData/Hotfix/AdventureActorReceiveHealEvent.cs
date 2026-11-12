public class AdventureActorReceiveHealEvent : BaseAdventureEvent
{
	public AdventureActor from;

	public AdventureActor to;

	public int value;

	public static AdventureActorReceiveHealEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorReceiveHealEvent>("ADVENTURE_ACTOR_RECEIVE_HEAL");
	}

	public AdventureActorReceiveHealEvent()
		: base("ADVENTURE_ACTOR_RECEIVE_HEAL")
	{
	}

	public override void Clear()
	{
		from = null;
		to = null;
		value = 0;
	}
}
