public class AdventureActorAttributeWithElementOrDamageTypeChangeEvent : BaseAdventureEvent
{
	public static AdventureActorAttributeWithElementOrDamageTypeChangeEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorAttributeWithElementOrDamageTypeChangeEvent>("ACTOR_ATTRIBUTEWITHELEMENTORDAMAGETYPE_CHANGED");
	}

	public AdventureActorAttributeWithElementOrDamageTypeChangeEvent()
		: base("ACTOR_ATTRIBUTEWITHELEMENTORDAMAGETYPE_CHANGED")
	{
	}
}
