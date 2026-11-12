public class AchievementEvent : BaseAdventureEvent
{
	public int evtId;

	public int count;

	public static AchievementEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AchievementEvent>("TRIGGER_ACHIEVEMENTEVT");
	}

	public AchievementEvent()
		: base("TRIGGER_PERFECTDODGE")
	{
	}

	public override void Clear()
	{
		evtId = 0;
		count = 0;
	}
}
