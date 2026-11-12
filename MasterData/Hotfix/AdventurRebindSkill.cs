public class AdventurRebindSkill : BaseAdventureEvent
{
	public int skillId;

	public ActionKey slotKey;

	public static AdventurRebindSkill Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurRebindSkill>("ACTOR_REBIND_SKILL");
	}

	public AdventurRebindSkill()
		: base("ACTOR_REBIND_SKILL")
	{
	}

	public override void Clear()
	{
		skillId = 0;
		slotKey = ActionKey.None;
	}
}
