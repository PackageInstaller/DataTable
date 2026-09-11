using System;

public sealed class SummerRaceActivityConfigCatalogProvider : ISummerRaceActivityCatalogProvider
{
	private readonly ISummerRaceActivityCatalogLoader loader;

	private readonly SummerRaceActivityLoadContext defaultContext;

	public SummerRaceActivityRuntimeCatalog CurrentCatalog { get; private set; }

	public SummerRaceActivityConfigCatalogProvider(ISummerRaceActivityCatalogLoader loader, SummerRaceActivityLoadContext defaultContext = null)
	{
		this.loader = loader;
		this.defaultContext = defaultContext;
		CurrentCatalog = null;
	}

	public SummerRaceActivityRuntimeCatalog Reload(SummerRaceActivityLoadContext context = null)
	{
		if (loader == null)
		{
			throw new InvalidOperationException("[SummerRaceActivityConfigCatalogProvider] loader is null.");
		}
		SummerRaceActivityLoadContext context2 = context ?? defaultContext ?? new SummerRaceActivityLoadContext();
		CurrentCatalog = loader.LoadCatalog(context2);
		return CurrentCatalog;
	}
}
