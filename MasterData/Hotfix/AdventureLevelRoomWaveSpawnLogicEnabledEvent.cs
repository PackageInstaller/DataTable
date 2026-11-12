public class AdventureLevelRoomWaveSpawnLogicEnabledEvent : BaseAdventureEvent
{
	public string wave;

	public static AdventureLevelRoomWaveSpawnLogicEnabledEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelRoomWaveSpawnLogicEnabledEvent>("BATTLE_ROOM_WAVE_SPAWNLOGIC_ENABLED");
	}

	public AdventureLevelRoomWaveSpawnLogicEnabledEvent()
		: base("BATTLE_ROOM_WAVE_SPAWNLOGIC_ENABLED")
	{
	}

	public override void Clear()
	{
		wave = null;
	}
}
