using TrueSync;

public class AdventureAreaEffectBeginEvent : BaseAdventureEvent
{
	public long entityID;

	public AdventureActor owner;

	public FP duration;

	public static AdventureAreaEffectBeginEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureAreaEffectBeginEvent>("AREA_EFFECT_BEGIN");
	}

	public AdventureAreaEffectBeginEvent()
		: base("AREA_EFFECT_BEGIN")
	{
	}

	public override void Clear()
	{
		entityID = 0L;
		owner = null;
		duration = 0;
	}
}
