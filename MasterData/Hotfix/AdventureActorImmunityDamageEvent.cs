using System.Collections.Generic;

public class AdventureActorImmunityDamageEvent : BaseAdventureEvent
{
	public LogicEntity from;

	public LogicEntity to;

	public AdventureWeapon weapon;

	public DamageType attackType;

	public int hitDamageConfigId;

	public IList<int> hitDamageTag;

	public HotfixEnum.elementType elementType;

	public int uniqueAttackId;

	public static AdventureActorImmunityDamageEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorImmunityDamageEvent>("ACTOR_IMMUNITY_DAMAGE");
	}

	public AdventureActorImmunityDamageEvent()
		: base("ACTOR_IMMUNITY_DAMAGE")
	{
	}

	public override void Clear()
	{
		from = null;
		to = null;
		weapon = null;
		attackType = DamageType.None;
		hitDamageConfigId = 0;
		hitDamageTag = null;
		elementType = HotfixEnum.elementType.NONE;
		uniqueAttackId = 0;
	}
}
