public class AdventureAssistActorCastSkillEvent : BaseAdventureEvent
{
	public int actorId;

	public SkillEventInfo skillEventInfo;

	public static AdventureAssistActorCastSkillEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureAssistActorCastSkillEvent>("ADVENTURE_ASSIST_ACTOR_CASTSKILL");
	}

	public AdventureAssistActorCastSkillEvent()
		: base("ADVENTURE_ASSIST_ACTOR_CASTSKILL")
	{
	}

	public override void Clear()
	{
		actorId = 0;
		skillEventInfo?.Clear();
		skillEventInfo = null;
	}
}
