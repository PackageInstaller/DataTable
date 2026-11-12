public class AdventureGroupControllerToMonsterMessage : BaseAdventureEvent
{
	public string operationType;

	public long monsterId;

	public static AdventureGroupControllerToMonsterMessage Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureGroupControllerToMonsterMessage>("GROUPCONTROLLER_TO_MONSTER_MESSAGE");
	}

	public AdventureGroupControllerToMonsterMessage()
		: base("GROUPCONTROLLER_TO_MONSTER_MESSAGE")
	{
	}

	public override void Clear()
	{
		monsterId = 0L;
	}
}
