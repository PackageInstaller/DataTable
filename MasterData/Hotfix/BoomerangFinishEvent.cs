using TrueSync;

public class BoomerangFinishEvent : BaseAdventureEvent
{
	public AdventureActor owner;

	public TSVector2 position;

	public string tag;

	public bool catchSucess;

	public static BoomerangFinishEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<BoomerangFinishEvent>("BOOMERANG_FINISH");
	}

	public BoomerangFinishEvent()
		: base("BOOMERANG_FINISH")
	{
	}

	public override void Clear()
	{
		owner = null;
		tag = null;
		catchSucess = false;
	}
}
