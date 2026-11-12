public class AdventureLevelModuleMonsterClearedEvent : BaseAdventureEvent
{
	public int x;

	public int y;

	public static AdventureLevelModuleMonsterClearedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelModuleMonsterClearedEvent>("BATTLE_MODULE_MONSTER_CLEARED");
	}

	public AdventureLevelModuleMonsterClearedEvent()
		: base("BATTLE_MODULE_MONSTER_CLEARED")
	{
	}

	public override void Clear()
	{
	}
}
