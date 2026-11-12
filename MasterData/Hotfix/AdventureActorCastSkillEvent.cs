public class AdventureActorCastSkillEvent : BaseAdventureEvent
{
	public SkillEventInfo skillEventInfo;

	public static AdventureActorCastSkillEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorCastSkillEvent>("ADVENTURE_ACTOR_CASTSKILL");
	}

	public AdventureActorCastSkillEvent()
		: base("ADVENTURE_ACTOR_CASTSKILL")
	{
	}

	public override void Clear()
	{
		skillEventInfo?.Clear();
		skillEventInfo = null;
	}
}
