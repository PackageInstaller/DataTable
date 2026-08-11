namespace GameFramework.Scene;

public sealed class UnloadSceneSuccessEventArgs : GameFrameworkEventArgs
{
	public string SceneAssetName { get; private set; }

	public object UserData { get; private set; }

	public UnloadSceneSuccessEventArgs()
	{
		SceneAssetName = null;
		UserData = null;
	}

	public static UnloadSceneSuccessEventArgs Create(string sceneAssetName, object userData)
	{
		UnloadSceneSuccessEventArgs e = ReferencePool.Acquire<UnloadSceneSuccessEventArgs>();
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
