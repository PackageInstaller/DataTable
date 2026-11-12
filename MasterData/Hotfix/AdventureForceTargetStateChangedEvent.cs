public class AdventureForceTargetStateChangedEvent : BaseAdventureEvent
{
	public LogicEntity actor;

	public LogicEntity from;

	public static AdventureForceTargetStateChangedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureForceTargetStateChangedEvent>("FORCE_TARGET_STATE_CHANGE");
	}

	public AdventureForceTargetStateChangedEvent()
		: base("FORCE_TARGET_STATE_CHANGE")
	{
	}

	public override void Clear()
	{
		base.Clear();
		actor = null;
		from = null;
	}
}
