public class AdventureLevelReadyEvent : BaseAdventureEvent
{
	public static AdventureLevelReadyEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelReadyEvent>("ADVENTURE_LEVEL_READY");
	}

	public AdventureLevelReadyEvent()
		: base("ADVENTURE_LEVEL_READY")
	{
	}

	public override void Clear()
	{
	}
}
