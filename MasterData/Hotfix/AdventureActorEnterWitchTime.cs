public class AdventureActorEnterWitchTime : BaseAdventureEvent
{
	public AdventureActor owner;

	public AdventureActor attackTarget;

	public static AdventureActorEnterWitchTime Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorEnterWitchTime>("ACTOR_ENTER_WITCHTIME");
	}

	public AdventureActorEnterWitchTime()
		: base("ACTOR_ENTER_WITCHTIME")
	{
	}

	public override void Clear()
	{
		owner = null;
		attackTarget = null;
	}
}
