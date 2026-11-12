public class TriggerAttackState : TriggerConditionBase
{
	public bool inAttack;

	public override void DisableTrigger()
	{
		base.DisableTrigger();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("PLAYER_ALERT_STATE", OnAlertEvent);
	}

	public override void ToActive()
	{
		base.ToActive();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("PLAYER_ALERT_STATE", OnAlertEvent);
		if (SceneSingleton<AdventurePlayerController>.Instance.inAlert() == inAttack)
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
		if (((AdventureActorPLAYER_ALERT_STATEEvent)evt).inAlert == inAttack)
		{
			OnTrigger();
		}
	}
}
