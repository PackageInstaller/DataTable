public class AdventureDropBeginEvent : BaseAdventureEvent
{
	public long entityID;

	public AdventureActor owner;

	public string dropTag;

	public static AdventureDropBeginEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureDropBeginEvent>("DROP_EFFECT_BEGIN");
	}

	public AdventureDropBeginEvent()
		: base("DROP_EFFECT_BEGIN")
	{
	}

	public override void Clear()
	{
		entityID = 0L;
		owner = null;
		dropTag = string.Empty;
	}
}
