public class AdventureBattleReadyEvent : BaseAdventureEvent
{
	public static AdventureBattleReadyEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureBattleReadyEvent>("ADVENTURE_BATTLE_READY_MSG");
	}

	public AdventureBattleReadyEvent()
		: base("ADVENTURE_BATTLE_READY_MSG")
	{
	}

	public override void Clear()
	{
	}
}
