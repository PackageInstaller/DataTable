using System.Collections.Generic;

public class MonsterToughnessStateChangeEvent : BaseAdventureEvent
{
	public AdventureActor actor;

	public AdventureActor source;

	public IList<int> hitDamageTag;

	public bool isToughnessBroken;

	public static MonsterToughnessStateChangeEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<MonsterToughnessStateChangeEvent>("MONSTER_TOUGHNESS_STATECHANGE");
	}

	public MonsterToughnessStateChangeEvent()
		: base("MONSTER_TOUGHNESS_STATECHANGE")
	{
	}

	public override void Clear()
	{
		actor = null;
		source = null;
		hitDamageTag = null;
		isToughnessBroken = false;
	}
}
