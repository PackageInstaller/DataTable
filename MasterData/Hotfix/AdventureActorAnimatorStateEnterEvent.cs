public class AdventureActorAnimatorStateEnterEvent : BaseAdventureEvent
{
	public AkAnimatorAudio.State state;

	public static AdventureActorAnimatorStateEnterEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorAnimatorStateEnterEvent>("ACTOR_ANIMATORSTATE_ENTER");
	}

	public AdventureActorAnimatorStateEnterEvent()
		: base("ACTOR_ANIMATORSTATE_ENTER")
	{
	}

	public override void Clear()
	{
		state = AkAnimatorAudio.State.None;
	}
}
