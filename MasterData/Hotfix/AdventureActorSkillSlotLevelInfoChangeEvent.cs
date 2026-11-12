public class AdventureActorSkillSlotLevelInfoChangeEvent : BaseAdventureEvent
{
	public static AdventureActorSkillSlotLevelInfoChangeEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorSkillSlotLevelInfoChangeEvent>("ACTOR_SKILLSLOTLEVELINFO_CHANGED");
	}

	public AdventureActorSkillSlotLevelInfoChangeEvent()
		: base("ACTOR_SKILLSLOTLEVELINFO_CHANGED")
	{
	}
}
