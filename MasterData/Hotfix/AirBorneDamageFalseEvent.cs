using System.Collections.Generic;

public class AirBorneDamageFalseEvent : BaseAdventureEvent
{
	public LogicEntity from;

	public IList<int> hitDamageTag;

	public LogicEntity to;

	public AdventureWeapon weapon;

	public static AirBorneDamageFalseEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AirBorneDamageFalseEvent>("AIRBORNE_DAMAGE_FALSE");
	}

	public AirBorneDamageFalseEvent()
		: base("AIRBORNE_DAMAGE_FALSE")
	{
	}

	public override void Clear()
	{
		hitDamageTag = null;
		from = null;
		to = null;
		weapon = null;
	}
}
