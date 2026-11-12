public class AdventureLevelRoomWaveMonsterClearedEvent : BaseAdventureEvent
{
	public int x;

	public int y;

	public string wave;

	public string room;

	public bool isFinalWave;

	public static AdventureLevelRoomWaveMonsterClearedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelRoomWaveMonsterClearedEvent>("BATTLE_ROOM_WAVE_MONSTER_CLEARED");
	}

	public AdventureLevelRoomWaveMonsterClearedEvent()
		: base("BATTLE_ROOM_WAVE_MONSTER_CLEARED")
	{
	}

	public override void Clear()
	{
		wave = null;
	}
}
