public class AdventureActorBreakShield : BaseAdventureEvent
{
	public int shield;

	public AdventureActor from;

	public AdventureActor to;

	public bool timeFinish;

	public static AdventureActorBreakShield Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorBreakShield>("ACTOR_BREAK_SHIELD");
	}

	public AdventureActorBreakShield()
		: base("ACTOR_BREAK_SHIELD")
	{
	}

	public override void Clear()
	{
		shield = 0;
		from = null;
		to = null;
		timeFinish = false;
	}
}
