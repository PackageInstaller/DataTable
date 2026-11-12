public class AdventureAreaEnterExitEvent : BaseAdventureEvent
{
	public AdventureActor owner;

	public DeterministicCollider triggerCollider;

	public bool iEnter;

	public static AdventureAreaEnterExitEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureAreaEnterExitEvent>("AREA_EFFECT_ENTER_EXIT");
	}

	public AdventureAreaEnterExitEvent()
		: base("AREA_EFFECT_ENTER_EXIT")
	{
	}

	public override void Clear()
	{
		iEnter = false;
		triggerCollider = null;
		owner = null;
	}
}
