namespace GameFramework.Scene;

public sealed class LoadSceneFailureEventArgs : GameFrameworkEventArgs
{
	public string SceneAssetName { get; private set; }

	public string ErrorMessage { get; private set; }

	public object UserData { get; private set; }

	public LoadSceneFailureEventArgs()
	{
		SceneAssetName = null;
		ErrorMessage = null;
		UserData = null;
	}

	public static LoadSceneFailureEventArgs Create(string sceneAssetName, string errorMessage, object userData)
	{
		LoadSceneFailureEventArgs e = ReferencePool.Acquire<LoadSceneFailureEventArgs>();
		e.SceneAssetName = sceneAssetName;
		e.ErrorMessage = errorMessage;
		e.UserData = userData;
		return e;
	}

	public override void Clear()
	{
		SceneAssetName = null;
		ErrorMessage = null;
		UserData = null;
	}
}
