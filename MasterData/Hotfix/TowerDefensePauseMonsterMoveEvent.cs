public class TowerDefensePauseMonsterMoveEvent : BaseAdventureEvent
{
	public long monsterID;

	public static TowerDefensePauseMonsterMoveEvent Generate()
	{
		if (ModuleController<AdventureModuleController>.Instance == null)
		{
			return null;
		}
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<TowerDefensePauseMonsterMoveEvent>("TOWERDEFENSE_PAUSE_MONSTER_MOVE_EVT");
	}

	public TowerDefensePauseMonsterMoveEvent()
		: base("TOWERDEFENSE_PAUSE_MONSTER_MOVE_EVT")
	{
	}

	public override void Clear()
	{
		monsterID = 0L;
	}
}
