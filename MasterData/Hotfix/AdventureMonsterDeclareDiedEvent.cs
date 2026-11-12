public class AdventureMonsterDeclareDiedEvent : BaseAdventureEvent
{
	public long id;

	public int monsterID;

	public int callSpawnSrc;

	public HotfixEnum.monsterEpicType epicType;

	public static AdventureMonsterDeclareDiedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterDeclareDiedEvent>("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED");
	}

	public AdventureMonsterDeclareDiedEvent()
		: base("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED")
	{
	}

	public override void Clear()
	{
		id = 0L;
		monsterID = 0;
		callSpawnSrc = 0;
	}
}
