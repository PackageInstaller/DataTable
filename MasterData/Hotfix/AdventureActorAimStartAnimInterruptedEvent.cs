public class AdventureActorAimStartAnimInterruptedEvent : BaseAdventureEvent
{
	public static AdventureActorAimStartAnimInterruptedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorAimStartAnimInterruptedEvent>("ACTOR_AIM_START_ANIM_INTERRUPTED");
	}

	public AdventureActorAimStartAnimInterruptedEvent()
		: base("ACTOR_AIM_START_ANIM_INTERRUPTED")
	{
	}
}
