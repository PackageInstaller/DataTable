public class AdventureActorSkillHaveSectionAmountEvent : BaseAdventureEvent
{
	public int actorId;

	public int skillId;

	public bool haveSectionAmount;

	public static AdventureActorSkillHaveSectionAmountEvent Generate()
	{
		if (ModuleController<AdventureModuleController>.Instance == null)
		{
			return null;
		}
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorSkillHaveSectionAmountEvent>("ACTOR_SKILL_HAVE_SECTION_AMOUNT");
	}

	public AdventureActorSkillHaveSectionAmountEvent()
		: base("ACTOR_SKILL_HAVE_SECTION_AMOUNT")
	{
	}

	public override void Clear()
	{
		actorId = 0;
		skillId = 0;
	}
}
