using TrueSync;

public class AdventureActorSKillComboTimer : BaseAdventureEvent
{
	public bool enable;

	public FP startTime;

	public FP endTime;

	public static AdventureActorSKillComboTimer Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorSKillComboTimer>("SKILL_COMBO_TIMER");
	}

	public AdventureActorSKillComboTimer()
		: base("SKILL_COMBO_TIMER")
	{
	}

	public override void Clear()
	{
		base.Clear();
	}
}
