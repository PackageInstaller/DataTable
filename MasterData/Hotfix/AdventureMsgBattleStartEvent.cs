public class AdventureMsgBattleStartEvent : BaseAdventureEvent
{
	public static AdventureMsgBattleStartEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMsgBattleStartEvent>("ADVENTURE_BATTLE_START_MSG");
	}

	public AdventureMsgBattleStartEvent()
		: base("ADVENTURE_BATTLE_START_MSG")
	{
	}
}
