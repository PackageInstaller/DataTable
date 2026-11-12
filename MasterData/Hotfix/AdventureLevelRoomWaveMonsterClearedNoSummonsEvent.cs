public class AdventureLevelRoomWaveMonsterClearedNoSummonsEvent : BaseAdventureEvent
{
	public int x;

	public int y;

	public string wave;

	public string room;

	public bool isFinalWave;

	public static AdventureLevelRoomWaveMonsterClearedNoSummonsEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelRoomWaveMonsterClearedNoSummonsEvent>("BATTLE_ROOM_WAVE_MONSTER_CLEARED_NOSUMMONS");
	}

	public AdventureLevelRoomWaveMonsterClearedNoSummonsEvent()
		: base("BATTLE_ROOM_WAVE_MONSTER_CLEARED_NOSUMMONS")
	{
	}

	public override void Clear()
	{
		wave = null;
	}
}
