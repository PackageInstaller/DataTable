public class AdventureMonsterToGroupControllerMessage : BaseAdventureEvent
{
	public string operationType;

	public long monsterId;

	public static AdventureMonsterToGroupControllerMessage Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterToGroupControllerMessage>("MONSTER_TO_GROUPCONTROLLER_MESSAGE");
	}

	public AdventureMonsterToGroupControllerMessage()
		: base("MONSTER_TO_GROUPCONTROLLER_MESSAGE")
	{
	}

	public override void Clear()
	{
		monsterId = 0L;
	}
}
