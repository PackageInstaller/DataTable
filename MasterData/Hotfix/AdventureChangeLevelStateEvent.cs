public class AdventureChangeLevelStateEvent : BaseAdventureEvent
{
	public HotfixEnum.levelState levelState;

	public bool clearMonster;

	public static AdventureChangeLevelStateEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureChangeLevelStateEvent>("ADVENTURE_CHANGE_LEVEL_STATE");
	}

	public AdventureChangeLevelStateEvent()
		: base("ADVENTURE_CHANGE_LEVEL_STATE")
	{
	}

	public override void Clear()
	{
	}
}
