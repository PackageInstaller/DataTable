public class AdventureMsgBattleFinishEvent : BaseAdventureEvent
{
	public static AdventureMsgBattleFinishEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMsgBattleFinishEvent>("ADVENTURE_BATTLE_FINISH_MSG");
	}

	public AdventureMsgBattleFinishEvent()
		: base("ADVENTURE_BATTLE_FINISH_MSG")
	{
	}
}
