public class ActorTryCastSkill : BaseAdventureEvent
{
	public int skillId;

	public bool isInterruptAttack;

	public SkillPhaseFeatureFlag flag;

	public static ActorTryCastSkill Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<ActorTryCastSkill>("ACTOR_TRY_CAST_SKILL");
	}

	public ActorTryCastSkill()
		: base("ACTOR_TRY_CAST_SKILL")
	{
	}

	public override void Clear()
	{
		base.Clear();
		skillId = 0;
	}
}
