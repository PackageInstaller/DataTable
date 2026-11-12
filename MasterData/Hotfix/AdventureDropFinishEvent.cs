public class AdventureDropFinishEvent : BaseAdventureEvent
{
	public long entityID;

	public AdventureActor owner;

	public AdventureActor target;

	public string dropTag;

	public bool isPickUp;

	public static AdventureDropFinishEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureDropFinishEvent>("DROP_EFFECT_FINISH");
	}

	public AdventureDropFinishEvent()
		: base("DROP_EFFECT_FINISH")
	{
	}

	public override void Clear()
	{
		entityID = 0L;
		owner = null;
		target = null;
		dropTag = string.Empty;
		isPickUp = false;
	}
}
