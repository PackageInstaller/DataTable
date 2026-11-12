using System.Collections.Generic;

public class AdventureActorReceiveDamageCanCauseDeadEvent : BaseAdventureEvent
{
	public LogicEntity from;

	public LogicEntity to;

	public AdventureWeapon weapon;

	public DamageType attackType;

	public long value;

	public bool isCrit;

	public bool isDodge;

	public IList<int> hitDamageTag;

	public HotfixEnum.elementType elementType;

	public long uniqueAttackId;

	public static AdventureActorReceiveDamageCanCauseDeadEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorReceiveDamageCanCauseDeadEvent>("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD");
	}

	public AdventureActorReceiveDamageCanCauseDeadEvent()
		: base("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD")
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
		hitDamageTag = null;
		uniqueAttackId = 0L;
	}
}
