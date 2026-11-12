public class AdventureBulletReflectEvent : BaseAdventureEvent
{
	public static AdventureBulletReflectEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureBulletReflectEvent>("BULLET_REFLECT");
	}

	public AdventureBulletReflectEvent()
		: base("BULLET_REFLECT")
	{
	}

	public override void Clear()
	{
		base.Clear();
	}
}
