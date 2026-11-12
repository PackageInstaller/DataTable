using TrueSync;

public class AdventureBulletFinishEvent : BaseAdventureEvent
{
	public AdventureActor owner;

	public TSVector2 bulletPosition;

	public FP bulletPositionY;

	public string tag;

	public int bulletHashCode;

	public bool catched;

	public BulletFinishReason finishReason;

	public long id;

	public static AdventureBulletFinishEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureBulletFinishEvent>("BULLET_FINISH");
	}

	public AdventureBulletFinishEvent()
		: base("BULLET_FINISH")
	{
	}

	public override void Clear()
	{
		base.Clear();
		tag = "";
		owner = null;
		catched = false;
		finishReason = BulletFinishReason.Timeout;
		id = 0L;
	}
}
