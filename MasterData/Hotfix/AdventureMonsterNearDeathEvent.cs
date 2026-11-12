public class AdventureMonsterNearDeathEvent : BaseAdventureEvent
{
	public int dataID;

	public static AdventureMonsterNearDeathEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterNearDeathEvent>("ADVENTURE_BATTLE_MONSTER_NEAR_DEATH");
	}

	public AdventureMonsterNearDeathEvent()
		: base("ADVENTURE_BATTLE_MONSTER_NEAR_DEATH")
	{
	}

	public override void Clear()
	{
		dataID = 0;
	}
}
