public class AdventureSoldierSupportPromotedEvent : BaseAdventureEvent
{
	public long actorId;

	public int dataID;

	public static AdventureSoldierSupportPromotedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureSoldierSupportPromotedEvent>("ADVENTURE_SOLDIER_SUPPORT_PROMOTED");
	}

	public AdventureSoldierSupportPromotedEvent()
		: base("ADVENTURE_SOLDIER_SUPPORT_PROMOTED")
	{
	}

	public override void Clear()
	{
		actorId = 0L;
		dataID = 0;
	}
}
