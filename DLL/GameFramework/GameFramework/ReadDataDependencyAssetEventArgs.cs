namespace GameFramework;

public sealed class ReadDataDependencyAssetEventArgs : GameFrameworkEventArgs
{
	public string DataAssetName { get; private set; }

	public string DependencyAssetName { get; private set; }

	public int LoadedCount { get; private set; }

	public int TotalCount { get; private set; }

	public object UserData { get; private set; }

	public ReadDataDependencyAssetEventArgs()
	{
		DataAssetName = null;
		DependencyAssetName = null;
		LoadedCount = 0;
		TotalCount = 0;
		UserData = null;
	}

	public static ReadDataDependencyAssetEventArgs Create(string dataAssetName, string dependencyAssetName, int loadedCount, int totalCount, object userData)
	{
		ReadDataDependencyAssetEventArgs e = ReferencePool.Acquire<ReadDataDependencyAssetEventArgs>();
		e.DataAssetName = dataAssetName;
		e.DependencyAssetName = dependencyAssetName;
		e.LoadedCount = loadedCount;
		e.TotalCount = totalCount;
		e.UserData = userData;
		return e;
	}

	public override void Clear()
	{
		DataAssetName = null;
		DependencyAssetName = null;
		LoadedCount = 0;
		TotalCount = 0;
		UserData = null;
	}
}
