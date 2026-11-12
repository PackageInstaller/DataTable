public class AdventureMonsterSpawnedEvent : BaseAdventureEvent
{
	public long id;

	public int dataID;

	public int callSpawnSrc;

	public static AdventureMonsterSpawnedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterSpawnedEvent>("MONSTER_SPAWN");
	}

	public AdventureMonsterSpawnedEvent()
		: base("MONSTER_SPAWN")
	{
	}

	public override void Clear()
	{
		id = 0L;
	}
}
