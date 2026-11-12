public class AdventureBulletBornEvent : BaseAdventureEvent
{
	public AdventureActor owner;

	public string tag;

	public int bulletHashCode;

	public long id;

	public static AdventureBulletBornEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureBulletBornEvent>("BULLET_BORN");
	}

	public AdventureBulletBornEvent()
		: base("BULLET_BORN")
	{
	}

	public override void Clear()
	{
		base.Clear();
		tag = "";
		owner = null;
		id = 0L;
	}
}
