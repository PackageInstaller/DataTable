namespace GameFramework;

public sealed class ReadDataSuccessEventArgs : GameFrameworkEventArgs
{
	public string DataAssetName { get; private set; }

	public float Duration { get; private set; }

	public object UserData { get; private set; }

	public ReadDataSuccessEventArgs()
	{
		DataAssetName = null;
		Duration = 0f;
		UserData = null;
	}

	public static ReadDataSuccessEventArgs Create(string dataAssetName, float duration, object userData)
	{
		ReadDataSuccessEventArgs e = ReferencePool.Acquire<ReadDataSuccessEventArgs>();
		e.DataAssetName = dataAssetName;
		e.Duration = duration;
		e.UserData = userData;
		return e;
	}

	public override void Clear()
	{
		DataAssetName = null;
		Duration = 0f;
		UserData = null;
	}
}
