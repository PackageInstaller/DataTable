public class TriggerMonsterEnterAction : TriggerConditionBase
{
	public bool iEnemyAction;

	public override void DisableTrigger()
	{
		base.DisableTrigger();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_ENTERACTION_STATE", OnAlertEvent);
	}

	public override void ToActive()
	{
		base.ToActive();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_ENTERACTION_STATE", OnAlertEvent);
		bool flag = iEnemyAction;
		AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
		if (flag == ((object)instance != null && instance.getActionEnemyCount() > 0))
		{
			OnTrigger();
		}
	}

	public override void OnTrigger()
	{
		if (CanTrigger())
		{
			base.OnTrigger();
		}
	}

	public void OnAlertEvent(IEvent evt)
	{
		AdventureActorMONSTER_ENTERACTION_STATEEvent adventureActorMONSTER_ENTERACTION_STATEEvent = (AdventureActorMONSTER_ENTERACTION_STATEEvent)evt;
		if (iEnemyAction == adventureActorMONSTER_ENTERACTION_STATEEvent.enemyCount > 0)
		{
			OnTrigger();
		}
	}
}
