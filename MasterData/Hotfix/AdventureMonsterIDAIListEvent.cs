public class AdventureMonsterIDAIListEvent : BaseAdventureEvent
{
	public long monsterId;

	public static AdventureMonsterIDAIListEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterIDAIListEvent>("ADVENTURE_MONSTER_ID_AILIST");
	}

	public AdventureMonsterIDAIListEvent()
		: base("ADVENTURE_MONSTER_ID_AILIST")
	{
	}

	public override void Clear()
	{
		monsterId = 0L;
	}
}
