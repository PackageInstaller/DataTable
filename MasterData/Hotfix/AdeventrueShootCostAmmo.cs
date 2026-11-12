public class AdeventrueShootCostAmmo : BaseAdventureEvent
{
	public static AdeventrueShootCostAmmo Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdeventrueShootCostAmmo>("ACTOR_SHOOT_COST_AMMO");
	}

	public AdeventrueShootCostAmmo()
		: base("ACTOR_SHOOT_COST_AMMO")
	{
	}

	public override void Clear()
	{
		base.Clear();
	}
}
