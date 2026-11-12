public class AdventureMsgStartCountTimeEvent : BaseAdventureEvent
{
	public static AdventureMsgStartCountTimeEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMsgStartCountTimeEvent>("ADVENTURE_BATTLE_START_COUNT_TIME");
	}

	public AdventureMsgStartCountTimeEvent()
		: base("ADVENTURE_BATTLE_START_COUNT_TIME")
	{
	}
}
