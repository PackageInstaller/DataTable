public class AdventureActorPLAYER_ALERT_STATEEvent : BaseAdventureEvent
{
	public bool inAlert;

	public static AdventureActorPLAYER_ALERT_STATEEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorPLAYER_ALERT_STATEEvent>("PLAYER_ALERT_STATE");
	}

	public AdventureActorPLAYER_ALERT_STATEEvent()
		: base("PLAYER_ALERT_STATE")
	{
	}

	public override void Clear()
	{
		base.Clear();
		inAlert = false;
	}
}
