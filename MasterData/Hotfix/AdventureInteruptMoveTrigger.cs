public class AdventureInteruptMoveTrigger : BaseAdventureEvent
{
	public static AdventureInteruptMoveTrigger Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureInteruptMoveTrigger>("INTERRUPTMOVE");
	}

	public AdventureInteruptMoveTrigger()
		: base("INTERRUPTMOVE")
	{
	}

	public override void Clear()
	{
	}
}
