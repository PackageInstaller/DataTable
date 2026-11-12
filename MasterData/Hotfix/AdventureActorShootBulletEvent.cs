public class AdventureActorShootBulletEvent : BaseAdventureEvent
{
	public AdventureWeapon bullet;

	public static AdventureActorShootBulletEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorShootBulletEvent>("ADVENTURE_ACTOR_SHOOT_BULLET");
	}

	public AdventureActorShootBulletEvent()
		: base("ADVENTURE_ACTOR_SHOOT_BULLET")
	{
	}

	public override void Clear()
	{
		bullet = null;
	}
}
