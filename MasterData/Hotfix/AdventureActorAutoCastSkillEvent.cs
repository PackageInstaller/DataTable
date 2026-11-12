public class AdventureActorAutoCastSkillEvent : BaseAdventureEvent
{
	public int actorId;

	public ActionKey actionKey;

	public static AdventureActorAutoCastSkillEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorAutoCastSkillEvent>("ADVENTURE_ACTOR_AUTO_CASTSKILL");
	}

	public AdventureActorAutoCastSkillEvent()
		: base("ADVENTURE_ACTOR_AUTO_CASTSKILL")
	{
	}

	public override void Clear()
	{
		actorId = 0;
		actionKey = ActionKey.None;
	}
}
