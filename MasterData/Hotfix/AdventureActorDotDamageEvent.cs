using System.Collections.Generic;

public class AdventureActorDotDamageEvent : BaseAdventureEvent
{
	public LogicEntity from;

	public LogicEntity to;

	public DamageType attackType;

	public long damage;

	public long damageToShieldAndHp;

	public long damageToHp;

	public HotfixEnum.elementType elementType;

	public int hitDamageId;

	public IList<int> hitDamageTag;

	public long damageToughness;

	public static AdventureActorDotDamageEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorDotDamageEvent>("ACTOR_RECEIVE_DOT_DAMAGE");
	}

	public AdventureActorDotDamageEvent()
		: base("ACTOR_RECEIVE_DOT_DAMAGE")
	{
	}

	public override void Clear()
	{
		from = null;
		to = null;
		attackType = DamageType.None;
		damage = 0L;
		damageToShieldAndHp = 0L;
		hitDamageId = 0;
		hitDamageTag = null;
		damageToughness = 0L;
	}
}
