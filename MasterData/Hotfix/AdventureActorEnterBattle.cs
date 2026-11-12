public class AdventureActorEnterBattle : BaseAdventureEvent
{
	public static AdventureActorEnterBattle Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorEnterBattle>("ACTOR_ENTER_BATTLE");
	}

	public AdventureActorEnterBattle()
		: base("ACTOR_ENTER_BATTLE")
	{
	}
}
