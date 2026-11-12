public class AdventureBullutFinishTrigger : BaseAdventureEvent
{
	public AdventureActor actor;

	public static AdventureBullutFinishTrigger Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureBullutFinishTrigger>("TRIGGER_BULLUT_FINISH");
	}

	public AdventureBullutFinishTrigger()
		: base("TRIGGER_BULLUT_FINISH")
	{
	}

	public override void Clear()
	{
		actor = null;
	}
}
