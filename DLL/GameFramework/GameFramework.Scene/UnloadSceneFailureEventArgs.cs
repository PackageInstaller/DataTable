namespace GameFramework.Scene;

public sealed class UnloadSceneFailureEventArgs : GameFrameworkEventArgs
{
	public string SceneAssetName { get; private set; }

	public object UserData { get; private set; }

	public UnloadSceneFailureEventArgs()
	{
		SceneAssetName = null;
		UserData = null;
	}

	public static UnloadSceneFailureEventArgs Create(string sceneAssetName, object userData)
	{
		UnloadSceneFailureEventArgs e = ReferencePool.Acquire<UnloadSceneFailureEventArgs>();
		e.SceneAssetName = sceneAssetName;
		e.UserData = userData;
		return e;
	}

	public override void Clear()
	{
		SceneAssetName = null;
		UserData = null;
	}
}
