using TrueSync;

public class TowerDefenseEnergyCapsuleEvent : BaseAdventureEvent
{
	public long entityID;

	public FP chargePercent;

	public static TowerDefenseEnergyCapsuleEvent Generate()
	{
		if (ModuleController<AdventureModuleController>.Instance == null)
		{
			return null;
		}
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<TowerDefenseEnergyCapsuleEvent>("TOWERDEFENSE_ENERGY_CAPSUILE_EVT");
	}

	public TowerDefenseEnergyCapsuleEvent()
		: base("TOWERDEFENSE_ENERGY_CAPSUILE_EVT")
	{
	}

	public override void Clear()
	{
	}
}
