public class AdventureMonsterSummonerSpawnedEvent : BaseAdventureEvent
{
	public long id;

	public int dataId;

	public long summonerId;

	public static AdventureMonsterSummonerSpawnedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterSummonerSpawnedEvent>("BATTLE_MONSTER_SUMMONER_SPAWNED");
	}

	public AdventureMonsterSummonerSpawnedEvent()
		: base("BATTLE_MONSTER_SUMMONER_SPAWNED")
	{
	}

	public override void Clear()
	{
		id = 0L;
		dataId = 0;
		summonerId = 0L;
	}
}
