public class AdventureActorGetBuff : BaseAdventureEvent
{
	public BuffEventInfo eventInfo = new BuffEventInfo();

	public BuffEntity buff;

	public AdventureActor from;

	public static AdventureActorGetBuff Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorGetBuff>("ACTOR_GET_BUFF");
	}

	public AdventureActorGetBuff()
		: base("ACTOR_GET_BUFF")
	{
	}

	public override void Clear()
	{
		eventInfo.Clear();
		from = null;
		buff = null;
	}
}
