using System.Collections.Generic;

public class AdventureActorReceiveDamageBeforeSettlementEvent : BaseAdventureEvent
{
	public enum HitType
	{
		Attack,
		Hit
	}

	public LogicEntity from;

	public LogicEntity firstFrom;

	public LogicEntity to;

	public AdventureWeapon weapon;

	public DamageType attackType;

	public int hitDamageConfigId;

	public IList<int> hitDamageTag;

	public HotfixEnum.elementType elementType;

	public int uniqueAttackId;

	public int onceAttackTargetCount;

	public HotfixEnum.skillSlotType skillSlotType;

	public HotfixEnum.damageType damageType;

	public static AdventureActorReceiveDamageBeforeSettlementEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorReceiveDamageBeforeSettlementEvent>("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT");
	}

	public AdventureActorReceiveDamageBeforeSettlementEvent()
		: base("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT")
	{
	}

	public override void Clear()
	{
		from = null;
		firstFrom = null;
		to = null;
		weapon = null;
		attackType = DamageType.None;
		hitDamageConfigId = 0;
		hitDamageTag = null;
		skillSlotType = HotfixEnum.skillSlotType.NONE;
	}
}
