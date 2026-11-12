public class AdventureActorSummonEvent : BaseAdventureEvent
{
	public int summonId;

	public AdventureActor summoner;

	public static AdventureActorSummonEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorSummonEvent>("ACTOR_SUMMON");
	}

	public AdventureActorSummonEvent()
		: base("ACTOR_SUMMON")
	{
	}

	public override void Clear()
	{
		base.Clear();
	}
}
