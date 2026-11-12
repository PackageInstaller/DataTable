public class TriggerSpawnMonster : TriggerConditionBase
{
	public enum TriggerType
	{
		Actived,
		Cleared,
		DestroyNum,
		AliveNum
	}

	public string waveName;

	public TriggerType triggerType;

	public int num;

	public bool includeSummons = true;

	private bool triggledNumCondition;

	public override void ToActive()
	{
		base.ToActive();
		if (triggerType == TriggerType.Actived)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_ROOM_WAVE_MONSTER_ACTIVED", RoomWaveMonsterActived);
		}
		else if (triggerType == TriggerType.Cleared)
		{
			if (includeSummons)
			{
				ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_ROOM_WAVE_MONSTER_CLEARED", RoomWaveMonsterCleared);
			}
			else
			{
				ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_ROOM_WAVE_MONSTER_CLEARED_NOSUMMONS", RoomWaveMonsterCleared_NoSummons);
			}
		}
		else
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_SPAWNPOINT_MSG", SpawnPointMsg);
		}
	}

	public override void DisableTrigger()
	{
		if (triggerType == TriggerType.Actived)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_ROOM_WAVE_MONSTER_ACTIVED", RoomWaveMonsterActived);
		}
		else if (triggerType == TriggerType.Cleared)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_ROOM_WAVE_MONSTER_CLEARED", RoomWaveMonsterCleared);
		}
		else
		{
			ModuleController<AdventureModuleController>.Instance.RemoveEventListener("BATTLE_SPAWNPOINT_MSG", SpawnPointMsg);
		}
	}

	protected void RoomWaveMonsterActived(IEvent ievent)
	{
		if (!string.IsNullOrEmpty(waveName) && ievent != null)
		{
			AdventureLevelRoomWaveMonsterActivedEvent adventureLevelRoomWaveMonsterActivedEvent = (AdventureLevelRoomWaveMonsterActivedEvent)ievent;
			if (adventureLevelRoomWaveMonsterActivedEvent.x == x && adventureLevelRoomWaveMonsterActivedEvent.y == y && waveName.Equals(adventureLevelRoomWaveMonsterActivedEvent.wave))
			{
				OnTrigger();
			}
		}
	}

	protected void RoomWaveMonsterCleared(IEvent ievent)
	{
		if (triggerType == TriggerType.Cleared && !string.IsNullOrEmpty(waveName) && ievent != null)
		{
			AdventureLevelRoomWaveMonsterClearedEvent adventureLevelRoomWaveMonsterClearedEvent = (AdventureLevelRoomWaveMonsterClearedEvent)ievent;
			if (adventureLevelRoomWaveMonsterClearedEvent.x == x && adventureLevelRoomWaveMonsterClearedEvent.y == y && waveName.Equals(adventureLevelRoomWaveMonsterClearedEvent.wave))
			{
				OnTrigger();
			}
		}
	}

	protected void RoomWaveMonsterCleared_NoSummons(IEvent ievent)
	{
		if (triggerType == TriggerType.Cleared && !string.IsNullOrEmpty(waveName) && ievent != null)
		{
			AdventureLevelRoomWaveMonsterClearedNoSummonsEvent adventureLevelRoomWaveMonsterClearedNoSummonsEvent = (AdventureLevelRoomWaveMonsterClearedNoSummonsEvent)ievent;
			if (adventureLevelRoomWaveMonsterClearedNoSummonsEvent.x == x && adventureLevelRoomWaveMonsterClearedNoSummonsEvent.y == y && waveName.Equals(adventureLevelRoomWaveMonsterClearedNoSummonsEvent.wave))
			{
				OnTrigger();
			}
		}
	}

	protected void SpawnPointMsg(IEvent ievent)
	{
		if (triggledNumCondition || ievent == null)
		{
			return;
		}
		AdventureSpawnPointMsg adventureSpawnPointMsg = (AdventureSpawnPointMsg)ievent;
		if (!waveName.Equals(adventureSpawnPointMsg.spawnWaveName))
		{
			return;
		}
		int num = int.MaxValue;
		num = ((triggerType != TriggerType.AliveNum) ? adventureSpawnPointMsg.waveDiedNum : adventureSpawnPointMsg.waveRemindNum);
		if (triggerType == TriggerType.DestroyNum)
		{
			if (num >= this.num)
			{
				triggledNumCondition = true;
				OnTrigger();
			}
		}
		else if (triggerType == TriggerType.AliveNum && num <= this.num)
		{
			triggledNumCondition = true;
			OnTrigger();
		}
	}
}
