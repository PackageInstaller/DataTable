public class AdventureActorGetEffect : BaseAdventureEvent
{
	public EffectSourceType sourceType;

	public int effectId;

	public AdventureActor from;

	public static AdventureActorGetEffect Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorGetEffect>("ACTOR_GET_EFFECT");
	}

	public AdventureActorGetEffect()
		: base("ACTOR_GET_EFFECT")
	{
	}

	public override void Clear()
	{
		from = null;
	}
}
