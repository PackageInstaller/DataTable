public class AdeventrueMulTargetsHitBegin : BaseAdventureEvent
{
	public static AdeventrueMulTargetsHitBegin Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdeventrueMulTargetsHitBegin>("ACTOR_MULTARGETS_HIT_BEGIN");
	}

	public AdeventrueMulTargetsHitBegin()
		: base("ACTOR_MULTARGETS_HIT_BEGIN")
	{
	}

	public override void Clear()
	{
		base.Clear();
	}
}
