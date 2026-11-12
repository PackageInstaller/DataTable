public class AdventureMonsterSpawnedBeforeEvent : BaseAdventureEvent
{
	public MonsterAdventureActor MonsterActor;

	public static AdventureMonsterSpawnedBeforeEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterSpawnedBeforeEvent>("MONSTER_SPAWN_BEFORE");
	}

	public AdventureMonsterSpawnedBeforeEvent()
		: base("MONSTER_SPAWN_BEFORE")
	{
	}

	public override void Clear()
	{
		MonsterActor = null;
	}
}
