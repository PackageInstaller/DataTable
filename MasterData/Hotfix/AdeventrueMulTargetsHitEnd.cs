public class AdeventrueMulTargetsHitEnd : BaseAdventureEvent
{
	public static AdeventrueMulTargetsHitEnd Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdeventrueMulTargetsHitEnd>("ACTOR_MULTARGETS_HIT_END");
	}

	public AdeventrueMulTargetsHitEnd()
		: base("ACTOR_MULTARGETS_HIT_END")
	{
	}

	public override void Clear()
	{
		base.Clear();
	}
}
