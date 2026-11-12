public class AdventureActorPlayerFirstEnterBattleStateEvent : BaseAdventureEvent
{
	public static AdventureActorPlayerFirstEnterBattleStateEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorPlayerFirstEnterBattleStateEvent>("PLAYER_FIRST_ENTER_BATTLE_STATE");
	}

	public AdventureActorPlayerFirstEnterBattleStateEvent()
		: base("PLAYER_FIRST_ENTER_BATTLE_STATE")
	{
	}
}
