public class AdventureMonsterSwitchCustomStateEvent : BaseAdventureEvent
{
	public bool commonHandle;

	public bool breakCurrentAction;

	public bool customHandle;

	public static AdventureMonsterSwitchCustomStateEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterSwitchCustomStateEvent>("MONSTER_SWITCH_CUSTOM_STATE");
	}

	public AdventureMonsterSwitchCustomStateEvent()
		: base("MONSTER_SWITCH_CUSTOM_STATE")
	{
	}

	public override void Clear()
	{
		commonHandle = false;
		breakCurrentAction = false;
		customHandle = false;
	}
}
