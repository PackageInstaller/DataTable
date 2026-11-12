public class AdventureActorProactiveReduceSkillSectionEvent : BaseAdventureEvent
{
	public SkillEventInfo skillEventInfo;

	public static AdventureActorProactiveReduceSkillSectionEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorProactiveReduceSkillSectionEvent>("ADVENTURE_ACTOR_PROACTIVE_REDUCESKILLSECTION");
	}

	public AdventureActorProactiveReduceSkillSectionEvent()
		: base("ADVENTURE_ACTOR_PROACTIVE_REDUCESKILLSECTION")
	{
	}

	public override void Clear()
	{
		skillEventInfo?.Clear();
		skillEventInfo = null;
	}
}
