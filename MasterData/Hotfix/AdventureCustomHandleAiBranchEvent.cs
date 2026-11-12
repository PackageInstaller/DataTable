using System.Collections.Generic;

public class AdventureCustomHandleAiBranchEvent : BaseAdventureEvent
{
	public AdventureActor target;

	public HotfixEnum.monsterAIBranchFollowEventType eventType;

	public List<int> ids;

	public static AdventureCustomHandleAiBranchEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureCustomHandleAiBranchEvent>("CUSTOM_HANDLE_AI_BRANCH");
	}

	public AdventureCustomHandleAiBranchEvent()
		: base("CUSTOM_HANDLE_AI_BRANCH")
	{
	}

	public override void Clear()
	{
		base.Clear();
		target = null;
		eventType = HotfixEnum.monsterAIBranchFollowEventType.NONE;
		ids?.Clear();
		ids = null;
	}
}
