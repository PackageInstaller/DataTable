public class AdventurePrologueLevelTriggerWind : BaseAdventureEvent
{
	public static AdventurePrologueLevelTriggerWind Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurePrologueLevelTriggerWind>("PROLOGUELEVEL_TRIGGERWIND");
	}

	public AdventurePrologueLevelTriggerWind()
		: base("PROLOGUELEVEL_TRIGGERWIND")
	{
	}

	public override void Clear()
	{
	}
}
