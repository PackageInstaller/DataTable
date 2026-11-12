using System.Collections.Generic;

public class AdventureActorAIListInfoEvent : BaseAdventureEvent
{
	public long monsterId;

	public Dictionary<int, List<int>> sequenceDict;

	public Dictionary<int, List<Dictionary<int, bool>>> poolBranchDict;

	public static AdventureActorAIListInfoEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorAIListInfoEvent>("ADVENTURE_ACTOR_AILIST_INFO");
	}

	public AdventureActorAIListInfoEvent()
		: base("ADVENTURE_ACTOR_AILIST_INFO")
	{
	}

	public override void Clear()
	{
		monsterId = 0L;
		sequenceDict?.Clear();
	}
}
