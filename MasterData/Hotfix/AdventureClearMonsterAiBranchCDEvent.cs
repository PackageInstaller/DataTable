public class AdventureClearMonsterAiBranchCDEvent : BaseAdventureEvent
{
	public static AdventureClearMonsterAiBranchCDEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureClearMonsterAiBranchCDEvent>("CLEAR_MONSTER_AI_BRANCH_CD");
	}

	public AdventureClearMonsterAiBranchCDEvent()
		: base("CLEAR_MONSTER_AI_BRANCH_CD")
	{
	}
}
