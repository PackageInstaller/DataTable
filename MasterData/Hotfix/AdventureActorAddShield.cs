using System.Collections.Generic;

public class AdventureActorAddShield : BaseAdventureEvent
{
	public AdventureActor from;

	public List<int> shieldTags = new List<int>();

	public int shieldId;

	public AdventureActor to;

	public static AdventureActorAddShield Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorAddShield>("ACTOR_ADD_SHIELD");
	}

	public AdventureActorAddShield()
		: base("ACTOR_ADD_SHIELD")
	{
	}

	public override void Clear()
	{
		shieldId = 0;
		from = null;
		shieldTags?.Clear();
		to = null;
	}
}
