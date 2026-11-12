using TrueSync;

public class AdventureTreasureBoxSpawnPosEvent : BaseAdventureEvent
{
	public TSVector2 boxPos;

	public int boxId;

	public static AdventureTreasureBoxSpawnPosEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureTreasureBoxSpawnPosEvent>("TREASURE_BOX_SPAWN");
	}

	public AdventureTreasureBoxSpawnPosEvent()
		: base("TREASURE_BOX_SPAWN")
	{
	}

	public override void Clear()
	{
		boxPos = TSVector2.zero;
		boxId = 0;
	}
}
