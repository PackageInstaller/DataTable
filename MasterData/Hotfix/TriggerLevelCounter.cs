public class TriggerLevelCounter : TriggerConditionBase
{
	public string counter;

	public int target;

	public override void ToActive()
	{
		base.ToActive();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("LEVEL_COUNTER", OnCounterVar);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("LEVEL_COUNTER", OnCounterVar);
	}

	private void OnCounterVar(IEvent evt)
	{
		if (evt is AdventureLevelCounterEvent adventureLevelCounterEvent)
		{
			AdventureLevelController levelInstance = ModuleController<AdventureModuleController>.Instance.levelInstance;
			if (levelInstance != null && levelInstance.dicLevelCounter.TryGetValue(adventureLevelCounterEvent.counter, out var value) && value == target)
			{
				OnTrigger();
			}
		}
	}
}
