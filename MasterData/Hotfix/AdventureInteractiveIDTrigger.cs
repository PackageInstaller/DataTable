public class AdventureInteractiveIDTrigger : BaseAdventureEvent
{
	public string interactiveID;

	public static AdventureInteractiveIDTrigger Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureInteractiveIDTrigger>("INTERACTIVEID");
	}

	public AdventureInteractiveIDTrigger()
		: base("INTERACTIVEID")
	{
	}

	public override void Clear()
	{
	}
}
