using TrueSync;

public class KasimiraSkillShootEvent : BaseAdventureEvent
{
	public TSVector2 shootPosition;

	public LogicEntity target;

	public static KasimiraSkillShootEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<KasimiraSkillShootEvent>("KASIMIRA_SKILL_SHOOT");
	}

	public KasimiraSkillShootEvent()
		: base("KASIMIRA_SKILL_SHOOT")
	{
	}

	public override void Clear()
	{
		shootPosition = default;
		target = null;
	}
}
