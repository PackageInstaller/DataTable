public class AdventurBreakSkill : BaseAdventureEvent
{
	public static AdventurBreakSkill Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurBreakSkill>("ACTOR_BREAK_SKILL");
	}

	public AdventurBreakSkill()
		: base("ACTOR_BREAK_SKILL")
	{
	}

	public override void Clear()
	{
	}
}
