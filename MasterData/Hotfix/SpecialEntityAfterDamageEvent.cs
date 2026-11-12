public class SpecialEntityAfterDamageEvent : BaseAdventureEvent
{
	public LogicEntity owner;

	public ISpecialEntity entity;

	public bool damaged;

	public long damage;

	public static SpecialEntityAfterDamageEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<SpecialEntityAfterDamageEvent>("SPECIAL_ENTITY_AFTER_DAMAGE");
	}

	public SpecialEntityAfterDamageEvent()
		: base("SPECIAL_ENTITY_AFTER_DAMAGE")
	{
	}

	public override void Clear()
	{
		base.Clear();
		owner = null;
		entity = null;
		damaged = false;
		damage = 0L;
	}
}
