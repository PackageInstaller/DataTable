public class AdventureActorReceiveKillEvent : BaseAdventureEvent
{
	public LogicEntity from;

	public LogicEntity to;

	public int curValue;

	public static AdventureActorReceiveKillEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorReceiveKillEvent>("ACTOR_RECEIVE_KILL");
	}

	public AdventureActorReceiveKillEvent()
		: base("ACTOR_RECEIVE_KILL")
	{
	}

	public override void Clear()
	{
		from = null;
		to = null;
		curValue = 0;
	}
}
