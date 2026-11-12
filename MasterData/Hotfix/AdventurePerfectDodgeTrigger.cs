public class AdventurePerfectDodgeTrigger : BaseAdventureEvent
{
	public AdventureActor actor;

	public static AdventurePerfectDodgeTrigger Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurePerfectDodgeTrigger>("TRIGGER_PERFECTDODGE");
	}

	public AdventurePerfectDodgeTrigger()
		: base("TRIGGER_PERFECTDODGE")
	{
	}

	public override void Clear()
	{
	}
}
