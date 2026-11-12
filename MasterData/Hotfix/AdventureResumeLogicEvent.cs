public class AdventureResumeLogicEvent : BaseAdventureEvent
{
	public static AdventureResumeLogicEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureResumeLogicEvent>("RESUME_LOGIC");
	}

	public AdventureResumeLogicEvent()
		: base("RESUME_LOGIC")
	{
	}
}
