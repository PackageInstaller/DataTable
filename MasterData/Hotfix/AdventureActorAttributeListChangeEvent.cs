public class AdventureActorAttributeListChangeEvent : BaseAdventureEvent
{
	public static AdventureActorAttributeListChangeEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorAttributeListChangeEvent>("ACTOR_ATTRIBUTELIST_CHANGED");
	}

	public AdventureActorAttributeListChangeEvent()
		: base("ACTOR_ATTRIBUTELIST_CHANGED")
	{
	}
}
