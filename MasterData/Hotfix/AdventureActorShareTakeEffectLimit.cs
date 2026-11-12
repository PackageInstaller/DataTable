public class AdventureActorShareTakeEffectLimit : BaseAdventureEvent
{
	public int effectId;

	public int ownerId;

	public int limit;

	public static AdventureActorShareTakeEffectLimit Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorShareTakeEffectLimit>("SHARE_EFFECT_TAKE_EFFECT_LIMIT");
	}

	public AdventureActorShareTakeEffectLimit()
		: base("SHARE_EFFECT_TAKE_EFFECT_LIMIT")
	{
	}

	public override void Clear()
	{
		effectId = 0;
		ownerId = 0;
	}
}
