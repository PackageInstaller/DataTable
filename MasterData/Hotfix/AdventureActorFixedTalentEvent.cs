public class AdventureActorFixedTalentEvent : BaseAdventureEvent
{
	public static AdventureActorFixedTalentEvent Generate()
	{
		if (ModuleController<AdventureModuleController>.Instance == null)
		{
			return null;
		}
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorFixedTalentEvent>("ACTOR_FIXEDROGUELIKE_TALENT");
	}

	public AdventureActorFixedTalentEvent()
		: base("ACTOR_FIXEDROGUELIKE_TALENT")
	{
	}

	public override void Clear()
	{
	}
}
