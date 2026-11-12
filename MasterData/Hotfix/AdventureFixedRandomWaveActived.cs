public class AdventureFixedRandomWaveActived : BaseAdventureEvent
{
	public bool isFirstWave;

	public bool isFinalWave;

	public static AdventureFixedRandomWaveActived Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureFixedRandomWaveActived>("FIXED_RANDOM_WAVE_ACTIVED");
	}

	public AdventureFixedRandomWaveActived()
		: base("FIXED_RANDOM_WAVE_ACTIVED")
	{
	}
}
