public class AdventureMonsterDiedEvent : BaseAdventureEvent
{
	public long summonId;

	public long id;

	public int monsterID;

	public int callSpawnSrc;

	public HotfixEnum.monsterEpicType epicType;

	public int indexOfSpawnWave;

	public static AdventureMonsterDiedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterDiedEvent>("ADVENTURE_BATTLE_MONSTER_DIED");
	}

	public AdventureMonsterDiedEvent()
		: base("ADVENTURE_BATTLE_MONSTER_DIED")
	{
	}

	public override void Clear()
	{
		id = 0L;
		monsterID = 0;
		summonId = 0L;
	}
}
