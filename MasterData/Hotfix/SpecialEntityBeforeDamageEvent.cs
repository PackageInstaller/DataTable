public class SpecialEntityBeforeDamageEvent : BaseAdventureEvent
{
	public LogicEntity owner;

	public ISpecialEntity entity;

	public static SpecialEntityBeforeDamageEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<SpecialEntityBeforeDamageEvent>("SPECIAL_ENTITY_BEFORE_DAMAGE");
	}

	public SpecialEntityBeforeDamageEvent()
		: base("SPECIAL_ENTITY_BEFORE_DAMAGE")
	{
	}

	public override void Clear()
	{
		base.Clear();
		owner = null;
		entity = null;
	}
}
