public class FireflySkillShootEvent : BaseAdventureEvent
{
	public string bulletKey;

	public int bulletIndex;

	public AdventureActor target;

	public static FireflySkillShootEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<FireflySkillShootEvent>("FIREFLY_SKILL_SHOOT");
	}

	public FireflySkillShootEvent()
		: base("FIREFLY_SKILL_SHOOT")
	{
	}

	public override void Clear()
	{
		bulletKey = null;
		bulletIndex = 0;
		target = null;
	}
}
