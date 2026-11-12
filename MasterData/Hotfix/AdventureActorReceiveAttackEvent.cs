using System.Collections.Generic;

public class AdventureActorReceiveAttackEvent : BaseAdventureEvent
{
	public LogicEntity from;

	public LogicEntity firstFrom;

	public LogicEntity to;

	public AdventureWeapon weapon;

	public int hitDamageId;

	public IList<int> hitDamageTag;

	public int uniqueAttackId;

	public int onceAttackTargetCount;

	public static AdventureActorReceiveAttackEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorReceiveAttackEvent>("ACTOR_RECEIVE_ATTACK");
	}

	public AdventureActorReceiveAttackEvent()
		: base("ACTOR_RECEIVE_ATTACK")
	{
	}

	public override void Clear()
	{
		from = null;
		firstFrom = null;
		to = null;
		hitDamageId = 0;
		hitDamageTag = null;
		uniqueAttackId = 0;
		onceAttackTargetCount = 0;
		weapon = null;
	}
}
