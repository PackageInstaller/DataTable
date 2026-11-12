public class AdventureInputEnable : BaseAdventureEvent
{
	public bool enbale;

	public static AdventureInputEnable Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureInputEnable>("INPUT_ENABLE");
	}

	public AdventureInputEnable()
		: base("INPUT_ENABLE")
	{
	}
}
