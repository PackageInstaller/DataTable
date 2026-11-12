public class AdventureMonsterDespawnedEvent : BaseAdventureEvent
{
	public long id;

	public long summonId;

	public static AdventureMonsterDespawnedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterDespawnedEvent>("ADVENTURE_BATTLE_MONSTER_DESPAWNED");
	}

	public AdventureMonsterDespawnedEvent()
		: base("ADVENTURE_BATTLE_MONSTER_DESPAWNED")
	{
	}

	public override void Clear()
	{
		id = 0L;
	}
}
