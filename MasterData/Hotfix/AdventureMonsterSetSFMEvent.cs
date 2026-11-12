public class AdventureMonsterSetSFMEvent : BaseAdventureEvent
{
	public MonsterAdventureActor owner;

	public static AdventureMonsterSetSFMEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterSetSFMEvent>("MONSTER_SETSFM");
	}

	public AdventureMonsterSetSFMEvent()
		: base("MONSTER_SETSFM")
	{
	}

	public override void Clear()
	{
		owner = null;
	}
}
