public class TowerDefenseMonsterActionCallbackEvent : BaseAdventureEvent
{
	public long monsterID;

	public int gridIndex;

	public int routeID;

	public static TowerDefenseMonsterActionCallbackEvent Generate()
	{
		if (ModuleController<AdventureModuleController>.Instance == null)
		{
			return null;
		}
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<TowerDefenseMonsterActionCallbackEvent>("TOWERDEFENSE_MONSTER_ACTION_CALLBACK_EVT");
	}

	public TowerDefenseMonsterActionCallbackEvent()
		: base("TOWERDEFENSE_MONSTER_ACTION_CALLBACK_EVT")
	{
	}

	public override void Clear()
	{
	}
}
