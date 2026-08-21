namespace GameFramework.Scene;

public sealed class LoadSceneSuccessEventArgs : GameFrameworkEventArgs
{
	public string SceneAssetName { get; private set; }

	public float Duration { get; private set; }

	public object UserData { get; private set; }

	public LoadSceneSuccessEventArgs()
	{
		SceneAssetName = null;
		Duration = 0f;
		UserData = null;
	}

	public static LoadSceneSuccessEventArgs Create(string sceneAssetName, float duration, object userData)
	{
		LoadSceneSuccessEventArgs e = ReferencePool.Acquire<LoadSceneSuccessEventArgs>();
		e.SceneAssetName = sceneAssetName;
		e.Duration = duration;
		e.UserData = userData;
		return e;
	}

	public override void Clear()
	{
		SceneAssetName = null;
		Duration = 0f;
		UserData = null;
	}
}
