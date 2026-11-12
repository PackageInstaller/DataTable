public class AdventureActorStartCheckBrokenBulletEvent : BaseAdventureEvent
{
	public LogicEntity entity;

	public static AdventureActorStartCheckBrokenBulletEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorStartCheckBrokenBulletEvent>("ACTOR_START_CHECK_BROKENLINE_BULLET");
	}

	public AdventureActorStartCheckBrokenBulletEvent()
		: base("ACTOR_START_CHECK_BROKENLINE_BULLET")
	{
	}

	public override void Clear()
	{
		base.Clear();
		entity = null;
	}
}
