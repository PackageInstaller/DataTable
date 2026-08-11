namespace GameFramework.Scene;

public sealed class LoadSceneUpdateEventArgs : GameFrameworkEventArgs
{
	public string SceneAssetName { get; private set; }

	public float Progress { get; private set; }

	public object UserData { get; private set; }

	public LoadSceneUpdateEventArgs()
	{
		SceneAssetName = null;
		Progress = 0f;
		UserData = null;
	}

	public static LoadSceneUpdateEventArgs Create(string sceneAssetName, float progress, object userData)
	{
		LoadSceneUpdateEventArgs e = ReferencePool.Acquire<LoadSceneUpdateEventArgs>();
		e.SceneAssetName = sceneAssetName;
		e.Progress = progress;
		e.UserData = userData;
		return e;
	}

	public override void Clear()
	{
		SceneAssetName = null;
		Progress = 0f;
		UserData = null;
	}
}
