using TrueSync;

public class DestructibleObjectBeDestoryEvent : BaseAdventureEvent
{
	public long configID;

	public TSVector2 pos;

	public static DestructibleObjectBeDestoryEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<DestructibleObjectBeDestoryEvent>("DESTRUCTIBLEOBJECT_DIE");
	}

	public DestructibleObjectBeDestoryEvent()
		: base("DESTRUCTIBLEOBJECT_DIE")
	{
	}

	public override void Clear()
	{
		configID = 0L;
		pos = TSVector2.zero;
	}
}
