public class AdventureInteractiveUITrigger : BaseAdventureEvent
{
	public string interactiveID;

	public bool showUI;

	public static AdventureInteractiveUITrigger Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureInteractiveUITrigger>("INTERACTIVEUI");
	}

	public AdventureInteractiveUITrigger()
		: base("INTERACTIVEUI")
	{
	}

	public override void Clear()
	{
	}
}
