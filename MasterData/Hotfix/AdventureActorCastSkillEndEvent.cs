public class AdventureActorCastSkillEndEvent : BaseAdventureEvent
{
	public SkillEventInfo skillEventInfo;

	public bool isRelease;

	public static AdventureActorCastSkillEndEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorCastSkillEndEvent>("ADVENTURE_ACTOR_CASTSKILL_END");
	}

	public AdventureActorCastSkillEndEvent()
		: base("ADVENTURE_ACTOR_CASTSKILL_END")
	{
	}

	public override void Clear()
	{
		skillEventInfo?.Clear();
		skillEventInfo = null;
		isRelease = false;
	}
}
