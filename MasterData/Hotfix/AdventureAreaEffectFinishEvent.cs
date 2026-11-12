public class AdventureAreaEffectFinishEvent : BaseAdventureEvent
{
	public long entityID;

	public AdventureActor owner;

	public bool durationEnd;

	public static AdventureAreaEffectFinishEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureAreaEffectFinishEvent>("AREA_EFFECT_FINISH");
	}

	public AdventureAreaEffectFinishEvent()
		: base("AREA_EFFECT_FINISH")
	{
	}

	public override void Clear()
	{
		entityID = 0L;
		owner = null;
	}
}
