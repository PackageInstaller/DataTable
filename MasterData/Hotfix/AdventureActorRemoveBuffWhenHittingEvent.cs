public class AdventureActorRemoveBuffWhenHittingEvent : BaseAdventureEvent
{
	public LogicEntity entity;

	public int buffId;

	public static AdventureActorRemoveBuffWhenHittingEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorRemoveBuffWhenHittingEvent>("ACTOR_REMOVE_BUFF_WHEN_HITTING");
	}

	public AdventureActorRemoveBuffWhenHittingEvent()
		: base("ACTOR_REMOVE_BUFF_WHEN_HITTING")
	{
	}

	public override void Clear()
	{
		base.Clear();
		entity = null;
		buffId = 0;
	}
}
