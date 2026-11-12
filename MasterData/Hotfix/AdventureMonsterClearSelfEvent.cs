public class AdventureMonsterClearSelfEvent : BaseAdventureEvent
{
	public long summonId;

	public long id;

	public int monsterID;

	public HotfixEnum.monsterEpicType epicType;

	public static AdventureMonsterClearSelfEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterClearSelfEvent>("ADVENTURE_BATTLE_MONSTER_CLEARSELF");
	}

	public AdventureMonsterClearSelfEvent()
		: base("ADVENTURE_BATTLE_MONSTER_CLEARSELF")
	{
	}

	public override void Clear()
	{
		id = 0L;
		monsterID = 0;
		summonId = 0L;
	}
}
