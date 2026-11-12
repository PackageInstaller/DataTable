public class TriggerLevelFinish : TriggerConditionBase
{
	public override void ToActive()
	{
		base.ToActive();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_CHANGE_LEVEL_STATE", OnLevelFinish);
	}

	public override void DisableTrigger()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_CHANGE_LEVEL_STATE", OnLevelFinish);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
	}

	private void OnLevelFinish(IEvent evt)
	{
		if (evt is AdventureChangeLevelStateEvent { levelState: HotfixEnum.levelState.Success })
		{
			OnTrigger();
		}
	}
}
