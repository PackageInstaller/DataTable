public class AdventureActorStateSwitchEvent : BaseAdventureEvent
{
	public long Id;

	public int dataId;

	public ActorState _acState;

	public bool isInDying;

	public static AdventureActorStateSwitchEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorStateSwitchEvent>("ACTOR_STATE_SWITCH");
	}

	public AdventureActorStateSwitchEvent()
		: base("ACTOR_STATE_SWITCH")
	{
	}

	public override void Clear()
	{
		Id = 0L;
		dataId = 0;
		_acState = ActorState.Null;
		isInDying = false;
	}
}
