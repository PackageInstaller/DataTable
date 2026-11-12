public class AdeventrueShootCost : BaseAdventureEvent
{
	public int cost;

	public static AdeventrueShootCost Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdeventrueShootCost>("ACTOR_SHOOT_COST");
	}

	public AdeventrueShootCost()
		: base("ACTOR_SHOOT_COST")
	{
	}

	public override void Clear()
	{
		base.Clear();
		cost = 0;
	}
}
