public class AdventureSkillRefCountTrigger : BaseAdventureEvent
{
	public RefType refType;

	public static AdventureSkillRefCountTrigger Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureSkillRefCountTrigger>("SKILL_REFCOUNT");
	}

	public AdventureSkillRefCountTrigger()
		: base("SKILL_REFCOUNT")
	{
	}

	public override void Clear()
	{
	}
}
