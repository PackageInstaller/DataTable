public class SpecialEntityBeginEvent : BaseAdventureEvent
{
	public ISpecialEntity entity;

	public AdventureActor owner;

	public static SpecialEntityBeginEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<SpecialEntityBeginEvent>("SPECIAL_ENTITY_BEGIN");
	}

	public SpecialEntityBeginEvent()
		: base("SPECIAL_ENTITY_BEGIN")
	{
	}

	public override void Clear()
	{
		base.Clear();
		entity = null;
		owner = null;
	}
}
