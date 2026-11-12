public class AdventureActorRepeatRefreshBuff : BaseAdventureEvent
{
	public BuffEntity buffEntity;

	public AdventureActor actor;

	public static AdventureActorRepeatRefreshBuff Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorRepeatRefreshBuff>("ACTOR_REPEAT_REFRESH_BUFF");
	}

	public AdventureActorRepeatRefreshBuff()
		: base("ACTOR_REPEAT_REFRESH_BUFF")
	{
	}

	public override void Clear()
	{
		buffEntity = null;
		actor = null;
	}
}
