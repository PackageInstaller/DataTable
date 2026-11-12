public class AdventureActorExitWitchTime : BaseAdventureEvent
{
	public AdventureActor owner;

	public AdventureActor attackTarget;

	public static AdventureActorExitWitchTime Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorExitWitchTime>("ACTOR_EXIT_WITCHTIME");
	}

	public AdventureActorExitWitchTime()
		: base("ACTOR_EXIT_WITCHTIME")
	{
	}

	public override void Clear()
	{
		owner = null;
		attackTarget = null;
	}
}
