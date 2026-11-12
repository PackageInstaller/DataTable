using TrueSync;

public class TowerDefenseMonsterActionEvent : BaseAdventureEvent
{
	public long monsterID;

	public TSVector2 nextPoint;

	public int nextGridIndex;

	public int actionIndex;

	public string actionParam;

	public int routeID;

	public int leftRouteLen;

	public static TowerDefenseMonsterActionEvent Generate()
	{
		if (ModuleController<AdventureModuleController>.Instance == null)
		{
			return null;
		}
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<TowerDefenseMonsterActionEvent>("TOWERDEFENSE_MONSTER_ACTION_EVT");
	}

	public TowerDefenseMonsterActionEvent()
		: base("TOWERDEFENSE_MONSTER_ACTION_EVT")
	{
	}

	public override void Clear()
	{
		monsterID = 0L;
		nextPoint = TSVector2.zero;
		actionIndex = 0;
		actionParam = null;
		routeID = 0;
		leftRouteLen = 0;
	}
}
