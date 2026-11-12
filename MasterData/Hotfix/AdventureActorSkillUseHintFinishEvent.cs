public class AdventureActorSkillUseHintFinishEvent : BaseAdventureEvent
{
	public int skillId;

	public static AdventureActorSkillUseHintFinishEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorSkillUseHintFinishEvent>("ACTOR_SKILLUSEHINT_FINISH");
	}

	public AdventureActorSkillUseHintFinishEvent()
		: base("ACTOR_SKILLUSEHINT_FINISH")
	{
	}

	public override void Clear()
	{
		skillId = 0;
	}
}
