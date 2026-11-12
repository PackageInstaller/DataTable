public class AdventureTreasureBoxDespawnEvent : BaseAdventureEvent
{
	public long uniqueID;

	public static AdventureTreasureBoxDespawnEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureTreasureBoxDespawnEvent>("TREASURE_BOX_DESPAWN");
	}

	public AdventureTreasureBoxDespawnEvent()
		: base("TREASURE_BOX_DESPAWN")
	{
	}

	public override void Clear()
	{
		uniqueID = 0L;
	}
}
