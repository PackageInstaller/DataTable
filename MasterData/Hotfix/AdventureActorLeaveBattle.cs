public class AdventureActorLeaveBattle : BaseAdventureEvent
{
	public static AdventureActorLeaveBattle Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorLeaveBattle>("ACTOR_LEAVE_BATTLE");
	}

	public AdventureActorLeaveBattle()
		: base("ACTOR_LEAVE_BATTLE")
	{
	}
}
