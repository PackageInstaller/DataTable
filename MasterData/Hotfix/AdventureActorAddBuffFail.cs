public class AdventureActorAddBuffFail : BaseAdventureEvent
{
	public int buffId;

	public BuffManager.BuffAddFailType failType;

	public AdventureActor actor;

	public static AdventureActorAddBuffFail Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorAddBuffFail>("ACTOR_ADDBUFF_FAIL");
	}

	public AdventureActorAddBuffFail()
		: base("ACTOR_ADDBUFF_FAIL")
	{
	}

	public override void Clear()
	{
		buffId = 0;
		actor = null;
	}
}
