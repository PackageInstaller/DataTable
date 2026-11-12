public class AdventurePauseLogicEvent : BaseAdventureEvent
{
	public static AdventurePauseLogicEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurePauseLogicEvent>("PAUSE_LOGIC");
	}

	public AdventurePauseLogicEvent()
		: base("PAUSE_LOGIC")
	{
	}
}
