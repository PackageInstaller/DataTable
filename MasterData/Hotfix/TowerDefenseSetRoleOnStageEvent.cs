public class TowerDefenseSetRoleOnStageEvent : BaseAdventureEvent
{
	public int dataID;

	public long entityID;

	public static TowerDefenseSetRoleOnStageEvent Generate()
	{
		if (ModuleController<AdventureModuleController>.Instance == null)
		{
			return null;
		}
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<TowerDefenseSetRoleOnStageEvent>("TOWERDEFENSE_SET_ROLE_ON_STAGE_EVT");
	}

	public TowerDefenseSetRoleOnStageEvent()
		: base("TOWERDEFENSE_SET_ROLE_ON_STAGE_EVT")
	{
	}

	public override void Clear()
	{
	}
}
