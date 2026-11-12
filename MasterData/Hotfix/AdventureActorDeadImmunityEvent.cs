public class AdventureActorDeadImmunityEvent : BaseAdventureEvent
{
	public LogicEntity from;

	public LogicEntity to;

	public AdventureWeapon weapon;

	public DamageType attackType;

	public long value;

	public bool isCrit;

	public bool isDodge;

	public HotfixEnum.elementType elementType;

	public static AdventureActorDeadImmunityEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorDeadImmunityEvent>("ADVENTURE_ACTOR_DEAD_IMMUNITY");
	}

	public AdventureActorDeadImmunityEvent()
		: base("ADVENTURE_ACTOR_DEAD_IMMUNITY")
	{
	}

	public override void Clear()
	{
		from = null;
		to = null;
		weapon = null;
		attackType = DamageType.None;
		value = 0L;
		isCrit = false;
		isDodge = false;
	}
}
