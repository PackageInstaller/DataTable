using System.Collections.Generic;

namespace AIScript.Trigger;

public class WeiLuoHuoDong : AIBase
{
	private readonly Dictionary<string, int> monsterWaves_TrapGroupIds = new Dictionary<string, int>
	{
		{ "Wave_1.1", 4 },
		{ "Wave_1", 1 },
		{ "Wave_2", 2 },
		{ "Wave_3", 3 }
	};

	private readonly Dictionary<string, int> monsterWaves_TrapGroupIds_Deactive = new Dictionary<string, int>
	{
		{ "Wave_1", 1 },
		{ "Wave_2", 2 },
		{ "Wave_1.2", 4 },
		{ "Wave_4", 3 }
	};

	private readonly HashSet<int> _activatedGroupIds = new HashSet<int>();

	public void OnEnable()
	{
		_activatedGroupIds.Clear();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BATTLE_ROOM_WAVE_SPAWNLOGIC_ENABLED", OnWaveSpawnLogicEnabled);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BATTLE_ROOM_WAVE_MONSTER_CLEARED", OnWaveMonsterCleared);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_ROOM_WAVE_SPAWNLOGIC_ENABLED", OnWaveSpawnLogicEnabled);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_ROOM_WAVE_MONSTER_CLEARED", OnWaveMonsterCleared);
		foreach (int activatedGroupId in _activatedGroupIds)
		{
			DispatchTrapActive(activatedGroupId, isActive: false);
		}
		_activatedGroupIds.Clear();
	}

	private void OnWaveSpawnLogicEnabled(IEvent evt)
	{
		if (evt is AdventureLevelRoomWaveSpawnLogicEnabledEvent adventureLevelRoomWaveSpawnLogicEnabledEvent && monsterWaves_TrapGroupIds.TryGetValue(adventureLevelRoomWaveSpawnLogicEnabledEvent.wave, out var value) && _activatedGroupIds.Add(value))
		{
			DispatchTrapActive(value, isActive: true);
		}
	}

	private void OnWaveMonsterCleared(IEvent evt)
	{
		if (evt is AdventureLevelRoomWaveMonsterClearedEvent adventureLevelRoomWaveMonsterClearedEvent && monsterWaves_TrapGroupIds_Deactive.TryGetValue(adventureLevelRoomWaveMonsterClearedEvent.wave, out var value))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventName = "weiluohuodongEvent";
			adventureActorCustomEvent.eventHashCode = value;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private void DispatchTrapActive(int groupId, bool isActive)
	{
		AdventureTrapActive adventureTrapActive = AdventureTrapActive.Generate();
		adventureTrapActive.GroupId = groupId;
		adventureTrapActive.isActive = isActive;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureTrapActive);
	}
}
