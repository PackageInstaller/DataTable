public class AdventureLevelLastMonsterEnterDiedEvent : BaseAdventureEvent
{
	public static AdventureLevelLastMonsterEnterDiedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelLastMonsterEnterDiedEvent>("BATTLE_LASTMONSTER_ENTERDIED");
	}

	public AdventureLevelLastMonsterEnterDiedEvent()
		: base("BATTLE_LASTMONSTER_ENTERDIED")
	{
	}

	public override void Clear()
	{
	}
}
