public class AdventureLevelMonsterClearedEvent : BaseAdventureEvent
{
	public bool isEmptyLevel;

	public static AdventureLevelMonsterClearedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelMonsterClearedEvent>("ADVENTURE_BATTLE_MONSTER_CLEARED");
	}

	public AdventureLevelMonsterClearedEvent()
		: base("ADVENTURE_BATTLE_MONSTER_CLEARED")
	{
	}

	public override void Clear()
	{
	}
}
