using TrueSync;

public class AdventureActorCheckBrokenBulletSuccessEvent : BaseAdventureEvent
{
	public TSVector2 bulletPosition;

	public LogicEntity entity;

	public AdventureBrokenLineBullet bullet;

	public string tag;

	public static AdventureActorCheckBrokenBulletSuccessEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorCheckBrokenBulletSuccessEvent>("ACTOR_CHECK_BROKENLINE_BULLET_SUCCESS");
	}

	public AdventureActorCheckBrokenBulletSuccessEvent()
		: base("ACTOR_CHECK_BROKENLINE_BULLET_SUCCESS")
	{
	}

	public override void Clear()
	{
		base.Clear();
		entity = null;
		bullet = null;
		tag = "";
	}
}
