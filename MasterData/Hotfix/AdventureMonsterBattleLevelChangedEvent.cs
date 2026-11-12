public class AdventureMonsterBattleLevelChangedEvent : BaseAdventureEvent
{
	public int oldLevel;

	public int newLevel;

	public static AdventureMonsterBattleLevelChangedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterBattleLevelChangedEvent>("MONSTER_BATTLELEVEL_CHANGED");
	}

	public AdventureMonsterBattleLevelChangedEvent()
		: base("MONSTER_BATTLELEVEL_CHANGED")
	{
	}

	public override void Clear()
	{
		base.Clear();
		oldLevel = 0;
		newLevel = 0;
	}
}
