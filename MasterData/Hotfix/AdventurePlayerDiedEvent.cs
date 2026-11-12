public class AdventurePlayerDiedEvent : BaseAdventureEvent
{
	public static AdventurePlayerDiedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurePlayerDiedEvent>("ADVENTURE_BATTLE_PLAYER_DIED");
	}

	public AdventurePlayerDiedEvent()
		: base("ADVENTURE_BATTLE_PLAYER_DIED")
	{
	}

	public override void Clear()
	{
	}
}
