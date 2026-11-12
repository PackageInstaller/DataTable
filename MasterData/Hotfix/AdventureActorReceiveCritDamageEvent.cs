using System.Collections.Generic;

public class AdventureActorReceiveCritDamageEvent : BaseAdventureEvent
{
	public LogicEntity from;

	public LogicEntity to;

	public AdventureWeapon weapon;

	public DamageType attackType;

	public HotfixEnum.elementType elementType;

	public int uniqueAttackId;

	public int onceAttackTargetCount;

	public int hitDamageConfigId;

	public IList<int> hitDamageTag;

	public HotfixEnum.skillSlotType skillSlotType;

	public static AdventureActorReceiveCritDamageEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorReceiveCritDamageEvent>("ACTOR_RECEIVE_CRIT_DAMAGE");
	}

	public AdventureActorReceiveCritDamageEvent()
		: base("ACTOR_RECEIVE_CRIT_DAMAGE")
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
		skillSlotType = HotfixEnum.skillSlotType.NONE;
	}
}
