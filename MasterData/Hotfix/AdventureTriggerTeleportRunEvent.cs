public class AdventureTriggerTeleportRunEvent : BaseAdventureEvent
{
	public static AdventureTriggerTeleportRunEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureTriggerTeleportRunEvent>("LEVEL_ON_TELEPORTER_TRIGGER_RUN");
	}

	public AdventureTriggerTeleportRunEvent()
		: base("LEVEL_ON_TELEPORTER_TRIGGER_RUN")
	{
	}

	public override void Clear()
	{
	}
}
