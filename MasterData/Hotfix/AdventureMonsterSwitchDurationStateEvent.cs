using TrueSync;

public class AdventureMonsterSwitchDurationStateEvent : BaseAdventureEvent
{
	public bool breakCurrentAction;

	public bool breakForceControl;

	public int lastStateIndex;

	public int nextStateIndex;

	public FP durationTime;

	public static AdventureMonsterSwitchDurationStateEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterSwitchDurationStateEvent>("MONSTER_SWITCH_DURATION_STATE");
	}

	public AdventureMonsterSwitchDurationStateEvent()
		: base("MONSTER_SWITCH_DURATION_STATE")
	{
	}

	public override void Clear()
	{
		breakCurrentAction = false;
		breakForceControl = false;
		lastStateIndex = -1;
		nextStateIndex = -1;
		durationTime = 0;
	}
}
