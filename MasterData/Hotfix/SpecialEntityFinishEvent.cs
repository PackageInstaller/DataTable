public class SpecialEntityFinishEvent : BaseAdventureEvent
{
	public ISpecialEntity entity;

	public static SpecialEntityFinishEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<SpecialEntityFinishEvent>("SPECIAL_ENTITY_FINISH");
	}

	public SpecialEntityFinishEvent()
		: base("SPECIAL_ENTITY_FINISH")
	{
	}

	public override void Clear()
	{
		base.Clear();
		entity = null;
	}
}
