public class AdventureActorRemoveEffect : BaseAdventureEvent
{
	public EffectSourceType sourceType;

	public int effectId;

	public AdventureActor from;

	public static AdventureActorRemoveEffect Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorRemoveEffect>("ACTOR_REMOVE_EFFECT");
	}

	public AdventureActorRemoveEffect()
		: base("ACTOR_REMOVE_EFFECT")
	{
	}

	public override void Clear()
	{
		from = null;
	}
}
