public class AdventureActorRunBranchEvent : BaseAdventureEvent
{
	public int skillId;

	public int branchId;

	public static AdventureActorRunBranchEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorRunBranchEvent>("ADVENTURE_ACTOR_RUN_BRANCH");
	}

	public AdventureActorRunBranchEvent()
		: base("ADVENTURE_ACTOR_RUN_BRANCH")
	{
	}

	public override void Clear()
	{
		skillId = 0;
		branchId = 0;
	}
}
