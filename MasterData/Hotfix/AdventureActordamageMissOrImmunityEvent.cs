public class AdventureActordamageMissOrImmunityEvent : BaseAdventureEvent
{
	public LogicEntity from;

	public LogicEntity to;

	public int hitDamageId;

	public int dmgType;

	public static AdventureActordamageMissOrImmunityEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActordamageMissOrImmunityEvent>("ACTOR_DAMAGE_MISSORIMMUNITY");
	}

	public AdventureActordamageMissOrImmunityEvent()
		: base("ACTOR_DAMAGE_MISSORIMMUNITY")
	{
	}

	public override void Clear()
	{
		from = null;
		to = null;
		hitDamageId = 0;
		dmgType = 0;
	}
}
