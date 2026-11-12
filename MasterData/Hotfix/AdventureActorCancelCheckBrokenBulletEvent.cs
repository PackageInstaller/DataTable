public class AdventureActorCancelCheckBrokenBulletEvent : BaseAdventureEvent
{
	public LogicEntity entity;

	public static AdventureActorCancelCheckBrokenBulletEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorCancelCheckBrokenBulletEvent>("ACTOR_CANCEL_CHECK_BROKENLINE_BULLET");
	}

	public AdventureActorCancelCheckBrokenBulletEvent()
		: base("ACTOR_CANCEL_CHECK_BROKENLINE_BULLET")
	{
	}

	public override void Clear()
	{
		base.Clear();
		entity = null;
	}
}
