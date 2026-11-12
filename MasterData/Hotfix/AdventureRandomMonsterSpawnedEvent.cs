public class AdventureRandomMonsterSpawnedEvent : BaseAdventureEvent
{
	public long id;

	public int dataID;

	public int callSpawnSrc;

	public static AdventureRandomMonsterSpawnedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureRandomMonsterSpawnedEvent>("RANDOM_MONSTER_SPAWN");
	}

	public AdventureRandomMonsterSpawnedEvent()
		: base("RANDOM_MONSTER_SPAWN")
	{
	}

	public override void Clear()
	{
		id = 0L;
	}
}
