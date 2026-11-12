public class TriggerMonsterHp : TriggerConditionBase
{
	public enum HpType
	{
		Greater,
		Less
	}

	public int monsterID;

	public HpType hpType;

	public int hpPencent;

	public override void ToActive()
	{
		base.ToActive();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_HP_CHANGED", OnHpChanged);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_HP_CHANGED", OnHpChanged);
	}

	private void OnHpChanged(IEvent evt)
	{
		AdventureActorHpChangedEvent adventureActorHpChangedEvent = (AdventureActorHpChangedEvent)evt;
		if (!(adventureActorHpChangedEvent.sender is MonsterAdventureActor monsterAdventureActor) || monsterAdventureActor.dataID != monsterID)
		{
			return;
		}
		int num = (int)(long)(adventureActorHpChangedEvent.currentHp / adventureActorHpChangedEvent.maxHp * 100);
		if (hpType == HpType.Greater)
		{
			if (num >= hpPencent)
			{
				OnTrigger();
			}
		}
		else if (num <= hpPencent)
		{
			OnTrigger();
		}
	}
}
