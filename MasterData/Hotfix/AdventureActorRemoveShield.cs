using System.Collections.Generic;

public class AdventureActorRemoveShield : BaseAdventureEvent
{
	public AdventureActor from;

	public int shieldId;

	public ShiledRemoveType removeType;

	public LogicEntity damageFrom;

	public List<int> shieldTags = new List<int>();

	public static AdventureActorRemoveShield Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorRemoveShield>("ACTOR_REMOVE_SHIELD");
	}

	public AdventureActorRemoveShield()
		: base("ACTOR_REMOVE_SHIELD")
	{
	}

	public override void Clear()
	{
		shieldId = 0;
		from = null;
		damageFrom = null;
		shieldTags?.Clear();
		removeType = ShiledRemoveType.None;
	}
}
