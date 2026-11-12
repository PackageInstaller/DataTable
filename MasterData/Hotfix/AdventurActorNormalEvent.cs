public class AdventurActorNormalEvent : BaseAdventureEvent
{
	public int stateID;

	public string enventTag;

	public static AdventurActorNormalEvent Generate()
	{
		if (ModuleController<AdventureModuleController>.Instance == null)
		{
			return null;
		}
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurActorNormalEvent>("ACTOR_NORMAL_EVENT");
	}

	public AdventurActorNormalEvent()
		: base("ACTOR_NORMAL_EVENT")
	{
	}

	public override void Clear()
	{
		stateID = 0;
		enventTag = "";
	}
}
