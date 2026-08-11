namespace GameFramework.Scene;

public sealed class LoadSceneDependencyAssetEventArgs : GameFrameworkEventArgs
{
	public string SceneAssetName { get; private set; }

	public string DependencyAssetName { get; private set; }

	public int LoadedCount { get; private set; }

	public int TotalCount { get; private set; }

	public object UserData { get; private set; }

	public LoadSceneDependencyAssetEventArgs()
	{
		SceneAssetName = null;
		DependencyAssetName = null;
		LoadedCount = 0;
		TotalCount = 0;
		UserData = null;
	}

	public static LoadSceneDependencyAssetEventArgs Create(string sceneAssetName, string dependencyAssetName, int loadedCount, int totalCount, object userData)
	{
		LoadSceneDependencyAssetEventArgs e = ReferencePool.Acquire<LoadSceneDependencyAssetEventArgs>();
		e.SceneAssetName = sceneAssetName;
		e.DependencyAssetName = dependencyAssetName;
		e.LoadedCount = loadedCount;
		e.TotalCount = totalCount;
		e.UserData = userData;
		return e;
	}

	public override void Clear()
	{
		SceneAssetName = null;
		DependencyAssetName = null;
		LoadedCount = 0;
		TotalCount = 0;
		UserData = null;
	}
}
