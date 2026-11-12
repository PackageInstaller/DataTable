public class AdventureActorEffectExecute : BaseAdventureEvent
{
	public int effectId;

	public string effectTag;

	public static AdventureActorEffectExecute Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorEffectExecute>("ACTOR_EFFECT_EXECUTE");
	}

	public AdventureActorEffectExecute()
		: base("ACTOR_EFFECT_EXECUTE")
	{
	}

	public override void Clear()
	{
		effectId = 0;
		effectTag = "";
	}
}
