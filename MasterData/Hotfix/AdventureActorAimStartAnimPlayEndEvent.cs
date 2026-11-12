public class AdventureActorAimStartAnimPlayEndEvent : BaseAdventureEvent
{
	public static AdventureActorAimStartAnimPlayEndEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorAimStartAnimPlayEndEvent>("ACTOR_AIM_START_ANIM_PLAY_END");
	}

	public AdventureActorAimStartAnimPlayEndEvent()
		: base("ACTOR_AIM_START_ANIM_PLAY_END")
	{
	}
}
