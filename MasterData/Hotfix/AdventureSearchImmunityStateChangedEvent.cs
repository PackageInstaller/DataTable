public class AdventureSearchImmunityStateChangedEvent : BaseAdventureEvent
{
	public LogicEntity actor;

	public bool searchImmunity;

	public static AdventureSearchImmunityStateChangedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureSearchImmunityStateChangedEvent>("SEARCHIMMUNITY_STATE_CHANGE");
	}

	public AdventureSearchImmunityStateChangedEvent()
		: base("SEARCHIMMUNITY_STATE_CHANGE")
	{
	}

	public override void Clear()
	{
		base.Clear();
		actor = null;
	}
}
