public class AdventureSummonCaskSkillEvent : BaseAdventureEvent
{
	public int skillId;

	public static AdventureSummonCaskSkillEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureSummonCaskSkillEvent>("ACTOR_SUMMON_CASTSKILL");
	}

	public AdventureSummonCaskSkillEvent()
		: base("ACTOR_SUMMON_CASTSKILL")
	{
	}

	public override void Clear()
	{
		skillId = 0;
	}
}
