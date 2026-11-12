using TrueSync;

public class AdventureActorShareEffectCd : BaseAdventureEvent
{
	public int effectId;

	public int ownerId;

	public FP cd;

	public static AdventureActorShareEffectCd Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorShareEffectCd>("SHARE_EFFECT_CD");
	}

	public AdventureActorShareEffectCd()
		: base("SHARE_EFFECT_CD")
	{
	}

	public override void Clear()
	{
		effectId = 0;
		ownerId = 0;
	}
}
