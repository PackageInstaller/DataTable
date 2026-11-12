public class HanaharaSkillShootEvent : BaseAdventureEvent
{
	public PlayerSkillBranchType branchType;

	public static HanaharaSkillShootEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<HanaharaSkillShootEvent>("HANAHARA_SKILL_SHOOT");
	}

	public HanaharaSkillShootEvent()
		: base("HANAHARA_SKILL_SHOOT")
	{
	}

	public override void Clear()
	{
		branchType = PlayerSkillBranchType.None;
	}
}
