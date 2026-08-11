namespace GameFramework;

public sealed class ReadDataUpdateEventArgs : GameFrameworkEventArgs
{
	public string DataAssetName { get; private set; }

	public float Progress { get; private set; }

	public object UserData { get; private set; }

	public ReadDataUpdateEventArgs()
	{
		DataAssetName = null;
		Progress = 0f;
		UserData = null;
	}

	public static ReadDataUpdateEventArgs Create(string dataAssetName, float progress, object userData)
	{
		ReadDataUpdateEventArgs e = ReferencePool.Acquire<ReadDataUpdateEventArgs>();
		e.DataAssetName = dataAssetName;
		e.Progress = progress;
		e.UserData = userData;
		return e;
	}

	public override void Clear()
	{
		DataAssetName = null;
		Progress = 0f;
		UserData = null;
	}
}
