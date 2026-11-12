using System.Collections.Generic;

public class AdventureActorRemoveBuff : BaseAdventureEvent
{
	public BuffEventInfo eventInfo = new BuffEventInfo();

	public List<AdventureActor> froms = new List<AdventureActor>();

	public static AdventureActorRemoveBuff Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorRemoveBuff>("ACTOR_REMOVE_BUFF");
	}

	public AdventureActorRemoveBuff()
		: base("ACTOR_REMOVE_BUFF")
	{
	}

	public override void Clear()
	{
		eventInfo.Clear();
		froms?.Clear();
	}
}
