public class AdventureActorAnimatorStateExitEvent : BaseAdventureEvent
{
	public AkAnimatorAudio.State state;

	public static AdventureActorAnimatorStateExitEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorAnimatorStateExitEvent>("ACTOR_ANIMATORSTATE_EXIT");
	}

	public AdventureActorAnimatorStateExitEvent()
		: base("ACTOR_ANIMATORSTATE_EXIT")
	{
	}

	public override void Clear()
	{
		state = AkAnimatorAudio.State.None;
	}
}
