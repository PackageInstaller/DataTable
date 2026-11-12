public class AdventurActorStateChange : BaseAdventureEvent
{
	public AdventureActor _actor;

	public int stateID;

	public bool iEnter;

	public static AdventurActorStateChange Generate()
	{
		if (ModuleController<AdventureModuleController>.Instance == null)
		{
			return null;
		}
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurActorStateChange>("ACORTSTATE_CHANGE");
	}

	public AdventurActorStateChange()
		: base("ACORTSTATE_CHANGE")
	{
	}

	public override void Clear()
	{
		_actor = null;
		stateID = 0;
		iEnter = false;
	}
}
