public class AdventureFixedRandomWaveCleared : BaseAdventureEvent
{
	public bool isFinalWave;

	public bool isFirstWave;

	public static AdventureFixedRandomWaveCleared Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureFixedRandomWaveCleared>("FIXED_RANDOM_WAVE_CLEARED");
	}

	public AdventureFixedRandomWaveCleared()
		: base("FIXED_RANDOM_WAVE_CLEARED")
	{
	}
}
