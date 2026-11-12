public class AdventureTrapCollisionEvent : BaseAdventureEvent
{
	public LogicEntity form;

	public LogicEntity to;

	public static AdventureTrapCollisionEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureTrapCollisionEvent>("TRAP_COLLISION");
	}

	public AdventureTrapCollisionEvent()
		: base("TRAP_COLLISION")
	{
	}

	public override void Clear()
	{
		base.Clear();
		form = null;
		to = null;
	}
}
