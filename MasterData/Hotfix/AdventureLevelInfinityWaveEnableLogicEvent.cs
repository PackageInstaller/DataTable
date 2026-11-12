public class AdventureLevelInfinityWaveEnableLogicEvent : BaseAdventureEvent
{
	public int waveIndex;

	public static AdventureLevelInfinityWaveEnableLogicEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelInfinityWaveEnableLogicEvent>("INFINITY_WAVE_ENABLELOGIC");
	}

	public AdventureLevelInfinityWaveEnableLogicEvent()
		: base("INFINITY_WAVE_ENABLELOGIC")
	{
	}

	public override void Clear()
	{
	}
}
