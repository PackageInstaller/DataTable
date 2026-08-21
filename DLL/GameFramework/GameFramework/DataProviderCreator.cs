using GameFramework.Resource;

namespace GameFramework;

public static class DataProviderCreator
{
	public static int GetCachedBytesSize<T>()
	{
		return DataProvider<T>.CachedBytesSize;
	}

	public static void EnsureCachedBytesSize<T>(int ensureSize)
	{
		DataProvider<T>.EnsureCachedBytesSize(ensureSize);
	}

	public static void FreeCachedBytes<T>()
	{
		DataProvider<T>.FreeCachedBytes();
	}

	public static IDataProvider<T> Create<T>(T owner, IResourceManager resourceManager, IDataProviderHelper<T> dataProviderHelper)
	{
		if (owner == null)
		{
			throw new GameFrameworkException("Owner is invalid.");
		}
		if (resourceManager == null)
		{
			throw new GameFrameworkException("Resource manager is invalid.");
		}
		if (dataProviderHelper == null)
		{
			throw new GameFrameworkException("Data provider helper is invalid.");
		}
		DataProvider<T> dataProvider = new DataProvider<T>(owner);
		dataProvider.SetResourceManager(resourceManager);
		dataProvider.SetDataProviderHelper(dataProviderHelper);
		return dataProvider;
	}
}
