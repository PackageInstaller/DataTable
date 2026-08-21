using System;

public sealed class SummerRaceActivityConfigCatalogLoader : ISummerRaceActivityCatalogLoader
{
	private readonly ISummerRaceActivityConfigSourceLoader sourceLoader;

	public SummerRaceActivityConfigCatalogLoader(ISummerRaceActivityConfigSourceLoader sourceLoader)
	{
		this.sourceLoader = sourceLoader;
	}

	public SummerRaceActivityRuntimeCatalog LoadCatalog(SummerRaceActivityLoadContext context)
	{
		if (sourceLoader == null)
		{
			throw new InvalidOperationException("[SummerRaceActivityConfigCatalogLoader] sourceLoader is null.");
		}
		return SummerRaceActivityConfigMapper.BuildCatalog(sourceLoader.LoadSourceData(context) ?? throw new InvalidOperationException("[SummerRaceActivityConfigCatalogLoader] sourceLoader returned null source."), context);
	}
}
