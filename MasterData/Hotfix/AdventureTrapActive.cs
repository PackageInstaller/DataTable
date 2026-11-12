public class AdventureTrapActive : BaseAdventureEvent
{
	public bool isActive;

	public int GroupId;

	public static AdventureTrapActive Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureTrapActive>("TRAP_ACTIVE");
	}

	public AdventureTrapActive()
		: base("TRAP_ACTIVE")
	{
	}

	public override void Clear()
	{
		isActive = false;
		GroupId = 0;
	}
}
