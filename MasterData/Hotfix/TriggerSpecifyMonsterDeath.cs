using TrueSync;

public class TriggerSpecifyMonsterDeath : TriggerConditionBase
{
	public int monsterID;

	public int monsterNum = 1;

	private int curCount;

	private TSVector2 monsterPos;

	public override void ToActive()
	{
		base.ToActive();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDeath);
	}

	public override void DisableTrigger()
	{
		curCount = 0;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDeath);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		curCount = 0;
	}

	protected void MonsterDeath(IEvent ievent)
	{
		if (monsterID == 0 || monsterNum == 0 || ievent == null)
		{
			return;
		}
		AdventureMonsterDiedEvent adventureMonsterDiedEvent = (AdventureMonsterDiedEvent)ievent;
		if (adventureMonsterDiedEvent.monsterID != monsterID)
		{
			return;
		}
		curCount++;
		if (curCount >= monsterNum)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(adventureMonsterDiedEvent.id);
			if (logicEntity != null)
			{
				monsterPos = logicEntity.tsTransform.Position;
			}
			OnTrigger();
		}
	}

	public TSVector2 GetPos()
	{
		return monsterPos;
	}
}
