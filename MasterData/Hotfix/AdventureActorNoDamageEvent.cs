using System.Collections.Generic;

public class AdventureActorNoDamageEvent : BaseAdventureEvent
{
	public LogicEntity from;

	public LogicEntity firstFrom;

	public LogicEntity to;

	public int hitDamageConfigId;

	public IList<int> hitDamageTag;

	public int uniqueAttackId;

	public AdventureWeapon weapon;

	public string weaponTag;

	public static AdventureActorNoDamageEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorNoDamageEvent>("ACTOR_RECEIVE_NODAMAGE");
	}

	public AdventureActorNoDamageEvent()
		: base("ACTOR_RECEIVE_NODAMAGE")
	{
	}

	public override void Clear()
	{
		from = null;
		firstFrom = null;
		to = null;
		hitDamageConfigId = 0;
		hitDamageTag = null;
		uniqueAttackId = 0;
		weapon = null;
		weaponTag = "";
	}
}
