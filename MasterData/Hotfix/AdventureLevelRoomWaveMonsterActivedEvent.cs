public class AdventureLevelRoomWaveMonsterActivedEvent : BaseAdventureEvent
{
	public int x;

	public int y;

	public string wave;

	public string room;

	public bool isFinalWave;

	public static AdventureLevelRoomWaveMonsterActivedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelRoomWaveMonsterActivedEvent>("BATTLE_ROOM_WAVE_MONSTER_ACTIVED");
	}

	public AdventureLevelRoomWaveMonsterActivedEvent()
		: base("BATTLE_ROOM_WAVE_MONSTER_ACTIVED")
	{
	}

	public override void Clear()
	{
		wave = null;
	}
}
