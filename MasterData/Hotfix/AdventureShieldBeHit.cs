using System.Collections.Generic;

public class AdventureShieldBeHit : BaseAdventureEvent
{
	public AdventureActor from;

	public int shieldId;

	public LogicEntity damageFrom;

	public List<int> shieldTags = new List<int>();

	public static AdventureShieldBeHit Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureShieldBeHit>("ACTOR_BEHIT_SHIELD");
	}

	public AdventureShieldBeHit()
		: base("ACTOR_BEHIT_SHIELD")
	{
	}

	public override void Clear()
	{
		shieldId = 0;
		from = null;
		damageFrom = null;
		shieldTags?.Clear();
	}
}
