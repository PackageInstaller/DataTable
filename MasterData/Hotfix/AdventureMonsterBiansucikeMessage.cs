public class AdventureMonsterBiansucikeMessage : BaseAdventureEvent
{
	public string operationType;

	public long monsterId;

	public static AdventureMonsterBiansucikeMessage Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterBiansucikeMessage>("MONSTER_BIANSUCIKE_MESSAGE");
	}

	public AdventureMonsterBiansucikeMessage()
		: base("MONSTER_BIANSUCIKE_MESSAGE")
	{
	}

	public override void Clear()
	{
		monsterId = 0L;
	}
}
