public class AdventureLevelInfinityWaveMonsterMsgEvent : BaseAdventureEvent
{
	public int laveCount;

	public int waveIndex;

	public static AdventureLevelInfinityWaveMonsterMsgEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelInfinityWaveMonsterMsgEvent>("INFINITY_WAVE_MONSTERMSG");
	}

	public AdventureLevelInfinityWaveMonsterMsgEvent()
		: base("INFINITY_WAVE_MONSTERMSG")
	{
	}

	public override void Clear()
	{
	}
}
