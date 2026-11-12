public class AdventureBulletBlockEvent : BaseAdventureEvent
{
	public AdventureActor owner;

	public static AdventureBulletBlockEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureBulletBlockEvent>("BULLET_BLOCK");
	}

	public AdventureBulletBlockEvent()
		: base("BULLET_BLOCK")
	{
	}

	public override void Clear()
	{
		base.Clear();
		owner = null;
	}
}
