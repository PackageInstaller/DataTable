using System.Collections.Generic;

public class AdventureActorReceiveDamageBeforeHitEvent : BaseAdventureEvent
{
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

	public long areaEffectId;

	public HotfixEnum.perkSlot perkSlot;

	public HotfixEnum.damageType damageType;

	public static AdventureActorReceiveDamageBeforeHitEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorReceiveDamageBeforeHitEvent>("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT");
	}

	public AdventureActorReceiveDamageBeforeHitEvent()
		: base("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT")
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
		areaEffectId = 0L;
		perkSlot = HotfixEnum.perkSlot.Null;
	}
}
