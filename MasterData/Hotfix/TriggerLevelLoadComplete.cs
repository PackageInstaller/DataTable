public class TriggerLevelLoadComplete : TriggerConditionBase
{
	public override void ToActive()
	{
		base.ToActive();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_LEVEL_LOAD_COMPLETE", OnLevelLoadComplete);
	}

	public override void DisableTrigger()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_LEVEL_LOAD_COMPLETE", OnLevelLoadComplete);
	}

	private void OnLevelLoadComplete(IEvent evt)
	{
		OnTrigger();
	}
}
