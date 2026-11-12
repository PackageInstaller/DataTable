using System.Collections.Generic;

public class AdventureActorMissDamageEvent : BaseAdventureEvent
{
	public LogicEntity from;

	public LogicEntity to;

	public AdventureWeapon weapon;

	public DamageType attackType;

	public int hitDamageConfigId;

	public IList<int> hitDamageTag;

	public HotfixEnum.elementType elementType;

	public int uniqueAttackId;

	public static AdventureActorMissDamageEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorMissDamageEvent>("ACTOR_MISS_DAMAGE");
	}

	public AdventureActorMissDamageEvent()
		: base("ACTOR_MISS_DAMAGE")
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
