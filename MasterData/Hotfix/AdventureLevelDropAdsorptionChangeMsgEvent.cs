public class AdventureLevelDropAdsorptionChangeMsgEvent : BaseAdventureEvent
{
	public HotfixEnum.dropEntityType dropType;

	public static AdventureLevelDropAdsorptionChangeMsgEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelDropAdsorptionChangeMsgEvent>("DROP_ADSORPTIONCHANGE");
	}

	public AdventureLevelDropAdsorptionChangeMsgEvent()
		: base("DROP_ADSORPTIONCHANGE")
	{
	}

	public override void Clear()
	{
	}
}
